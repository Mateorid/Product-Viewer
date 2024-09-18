import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/repository/product_repository.dart';

part 'products_state.dart';

class ProductCubit extends Cubit<ProductsState> {
  final ProductRepository _productRepository;
  ProductCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductsInitial());

  Future<void> getProducts() async {
    try {
      emit(ProductsLoading());
      final hasConnected = await InternetConnectionChecker().hasConnection;
      if (hasConnected) {
        final fetchedProducts = await _productRepository.getAllProducts();
        await _productRepository.cacheLoadedProducts(products: fetchedProducts);
        // final cachedProducts = await _productRepository.getCachedProducts(); //todo delete?
        emit(ProductsLoaded(response: fetchedProducts));
      } else {
        final cachedProducts = await _productRepository.getCachedProducts();
        emit(ProductsLoaded(response: cachedProducts));
      }
    } catch (e) {
      emit(ProductsError(error: e.toString()));
    }
  }
}
