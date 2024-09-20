import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/repository/product_repository.dart';
import 'package:product_viewer/util/helper_functions.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required int productLimitStep,
    required Duration throttleDuration,
    required InternetConnectionChecker internetConnectionChecker,
    required ProductRepository repository,
  })  : _throttleDuration = throttleDuration,
        _productLimitStep = productLimitStep,
        _productRepository = repository,
        _internetConnectionChecker = internetConnectionChecker,
        super(ProductInitial()) {
    /// Throttle events so they don't overload our API
    on<ProductFetched>(
      (_, emit) => _onPostFetched(emit),
      transformer: throttleDroppable(_throttleDuration),
    );
    on<RetryProductFetched>(
      (_, emit) {
        // Emit initial status to present user with loading indicator
        emit(state.copyWith(status: ProductsStatus.initial));
        return _onPostFetched(emit);
      },
      transformer: throttleDroppable(_throttleDuration),
    );
  }
  final ProductRepository _productRepository;
  final InternetConnectionChecker _internetConnectionChecker;

  /// Limit the amount of fetched products to prevent loading the whole list
  /// Only 10 since the demo API only have 20 items
  final int _productLimitStep;
  final Duration _throttleDuration;

  /// Handle ProductFetched event
  Future<void> _onPostFetched(Emitter<ProductState> emit) async {
    try {
      final hasConnection = await _internetConnectionChecker.hasConnection;

      /// If we have internet connection -> fetch anc cache new data
      if (hasConnection) {
        await _fetchAndCacheNewData(emit);
        return;
      }

      /// If there's no connection then check for cached data
      final cachedProducts = await _productRepository.getCachedProducts();

      /// If we have nothing cached return failure
      if (cachedProducts.isEmpty) {
        emit(state.copyWith(status: ProductsStatus.failure));
        return;
      }

      /// Else emit cached data
      emit(state.copyWith(
        status: ProductsStatus.success,
        products: cachedProducts,
        hasReachedMax: true,
        productFetchLimit: cachedProducts.length,
        loadedFromCache: true,
      ));
    } catch (_) {
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }

  Future<void> _fetchAndCacheNewData(Emitter<ProductState> emit) async {
    /// This is sub-optimal but necessary since the test API doesn't support starting index or any other kind of pagination
    /// Usually you would just fetch the new data and add them to the existing list or display a 2nd page etc.
    final newLimit = state.productFetchLimit + _productLimitStep;
    final fetchedProducts = await _productRepository.getProducts(
      limit: newLimit,
    );
    await _productRepository.cacheLoadedProducts(products: fetchedProducts);
    emit(state.copyWith(
      status: ProductsStatus.success,
      products: fetchedProducts,
      hasReachedMax: fetchedProducts.length < newLimit,
      productFetchLimit: newLimit,
      loadedFromCache: false,
    ));
  }
}
