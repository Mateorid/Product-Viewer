import 'package:product_viewer/products/models/product.dart';

abstract class ProductRepository {
  /// Fetch all available products
  Future<List<Product>> getAllProducts();

  /// Cache loaded products
  Future<void> cacheLoadedProducts({required List<Product> products});

  /// Retrieve cached products
  Future<List<Product>> getCachedProducts();
}
