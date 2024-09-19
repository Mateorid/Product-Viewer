import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/repository/product_repository.dart';

class HttpProductRepository implements ProductRepository {
  static const _urlAuthority = 'fakestoreapi.com';
  static const _urlProductsPath = 'products';
  final http.Client _client;
  final Box<Product> _productBox;

  HttpProductRepository(
      {required http.Client client, required Box<Product> productBox})
      : _client = client,
        _productBox = productBox;

  @override
  Future<List<Product>> getProducts({int limit = 0}) async {
    final response = await _client.get(
      Uri.https(_urlAuthority, _urlProductsPath, {'limit': limit.toString()}),
    );
    if (response.statusCode != 200) {
      throw Exception("Couldn't fetch data!");
    }
    final responseBody = jsonDecode(response.body) as List;
    return responseBody.map((product) => Product.fromJson(product)).toList();
  }

  @override
  Future<void> cacheLoadedProducts({required List<Product> products}) async {
    for (final product in products) {
      await _productBox.put(product.id, product);
    }
  }

  @override
  Future<List<Product>> getCachedProducts() async {
    return _productBox.values.toList();
  }
}
