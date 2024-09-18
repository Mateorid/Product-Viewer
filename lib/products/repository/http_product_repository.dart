import 'dart:convert';

import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/repository/product_repository.dart';
import 'package:http/http.dart' as http;

class HttpProductRepository implements ProductRepository {
  static const _urlAuthority = 'fakestoreapi.com';
  static const _urlProductsPath = 'products';
  final _client = http.Client();

  @override
  Future<List<Product>> getAllProducts() async {
    final response = await _client.get(
      Uri.https(_urlAuthority, _urlProductsPath),
    );

    if (response.statusCode != 200) {
      throw Exception("Couldn't fetch data!");
    }
    final responseBody = jsonDecode(response.body) as List;
    return responseBody.map((product) => Product.fromJson(product)).toList();
  }

  @override
  Future<void> cacheLoadedProducts({required List<Product> products}) async {
    // TODO: implement cacheLoadedProducts
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getCachedProducts() async {
    // TODO: implement getCachedProducts
    throw UnimplementedError();
  }
}
