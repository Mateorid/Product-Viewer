import 'package:product_viewer/products/models/product.dart';

abstract class ProductRepository {
  /// Fetch first [limit] products or if [limit] is `0` fetch all products
  Future<List<Product>> getProducts({int limit = 0});

  /// Cache loaded products
  Future<void> cacheLoadedProducts({required List<Product> products});

  /// Retrieve cached products
  Future<List<Product>> getCachedProducts();
}
