import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/models/product_rating.dart';
import 'package:product_viewer/products/repository/http_product_repository.dart';

import 'http_product_repository_test.mocks.dart'; // Import generated mock file

@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<Box<Product>>(),
]) // Automatically generate mock classes for these
void main() {
  late MockClient mockHttpClient;
  late MockBox mockProductBox;
  late HttpProductRepository productRepository;

  const product = Product(
    id: 1,
    title: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    imageUrl: 'http://test.com/image1.jpg',
    category: 'Category 1',
    rating: ProductRating(rate: 3.9, count: 120),
  );
  const product2 = Product(
    id: 2,
    title: 'Product 2',
    description: 'Description 2',
    price: 20.0,
    imageUrl: 'http://test.com/image2.jpg',
    category: 'Category 2',
    rating: ProductRating(rate: 3.9, count: 120),
  );

  setUp(() {
    mockHttpClient = MockClient();
    mockProductBox = MockBox();
    productRepository = HttpProductRepository(
      client: mockHttpClient,
      productBox: mockProductBox,
    );
  });

  group('HttpProductRepository', () {
    test('returns product list when getProducts is called successfully',
        () async {
      final responseBody = jsonEncode([
        {
          "id": 1,
          "title": "Product 1",
          "price": 10,
          "description": "Description 1",
          "category": "Category 1",
          "image": "http://test.com/image1.jpg",
          "rating": {"rate": 3.9, "count": 120},
        },
        {
          'id': 2,
          'title': 'Product 2',
          'price': 20.0,
          'description': 'Description 2',
          "category": "Category 2",
          "image": "http://test.com/image2.jpg",
          "rating": {"rate": 3.9, "count": 120},
        },
      ]);

      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(responseBody, 200),
      );

      final products = await productRepository.getProducts();
      expect(products.length, 2);
      expect(products[0], product);
      expect(products[1], product2);
    });

    test('throws an exception when getProducts fails', () async {
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      expect(productRepository.getProducts(), throwsException);
    });

    test('caches loaded products successfully', () async {
      await productRepository.cacheLoadedProducts(products: [product]);

      verify(mockProductBox.put(product.id, product)).called(1);
    });

    test('returns cached products when available', () async {
      when(mockProductBox.values).thenReturn([product]);

      final cachedProducts = await productRepository.getCachedProducts();
      expect(cachedProducts.length, 1);
      expect(cachedProducts[0], product);
    });
  });
}
