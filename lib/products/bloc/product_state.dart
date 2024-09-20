part of 'product_bloc.dart';

enum ProductsStatus { initial, success, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductsStatus.initial,
    this.products = const <Product>[],
    this.productFetchLimit = 0,
    this.hasReachedMax = false,
    this.loadedFromCache = false,
  });

  final ProductsStatus status;
  final List<Product> products;
  final int productFetchLimit;
  final bool hasReachedMax;
  final bool loadedFromCache;

  ProductState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
    bool? loadedFromCache,
    int? productFetchLimit,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadedFromCache: loadedFromCache ?? this.loadedFromCache,
      productFetchLimit: productFetchLimit ?? this.productFetchLimit,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        hasReachedMax,
        loadedFromCache,
        productFetchLimit,
      ];
}

final class ProductInitial extends ProductState {}
