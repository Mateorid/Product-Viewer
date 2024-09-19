import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/repository/product_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository _productRepository;
  ProductsCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductsInitial());

  Future<void> getProducts() async {
    try {
      emit(ProductsInitial());
      final hasConnection = await InternetConnectionChecker().hasConnection;
      if (hasConnection) {
        // Fetch and cache products
        final fetchedProducts = await _productRepository.getAllProducts();
        await _productRepository.cacheLoadedProducts(products: fetchedProducts);
        emit(ProductsLoaded(response: fetchedProducts));
      } else {
        // Check for cached products
        final cachedProducts = await _productRepository.getCachedProducts();
        // No internet connection and nothing cached
        if (cachedProducts.isEmpty) {
          emit(ProductsError(error: "No internet connection"));
          return;
        }
        // Emit cached products
        emit(ProductsLoaded(response: cachedProducts));
      }
    } catch (e) {
      emit(ProductsError(error: e.toString()));
    }
  }
}
