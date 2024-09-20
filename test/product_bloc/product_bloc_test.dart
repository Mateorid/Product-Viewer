import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/models/product_rating.dart';
import 'package:product_viewer/products/repository/product_repository.dart';

import 'product_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductRepository>(),
  MockSpec<InternetConnectionChecker>(),
])
void main() {
  late MockProductRepository mockProductRepository;
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  const duration = Duration.zero;
  const smallProductLimitStep = 2;
  const bigProductLimitStep = 10;

  const productList = [
    Product(
      id: 1,
      title: 'Test Product 1',
      description: 'Desc 1',
      price: 10.0,
      imageUrl: 'http://test.com/1',
      category: 'Cat 1',
      rating: ProductRating(rate: 4.5, count: 123),
    ),
    Product(
      id: 2,
      title: 'Test Product 2',
      description: 'Desc 2',
      price: 20.0,
      imageUrl: 'http://test.com/2',
      category: 'Cat 1',
      rating: ProductRating(rate: 2.5, count: 321),
    ),
  ];

  const bigProductList = [
    ...productList,
    ...productList,
    ...productList,
    ...productList,
    ...productList,
    ...productList,
  ];

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockInternetConnectionChecker = MockInternetConnectionChecker();
  });

  group('Response tests', () {
    blocTest<ProductBloc, ProductState>(
      'emits [ProductsStatus.success] when products are fetched successfully with internet connection',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenAnswer((_) async => productList);
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(
          status: ProductsStatus.success,
          products: productList,
          hasReachedMax: true,
          productFetchLimit: bigProductLimitStep,
          loadedFromCache: false,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductsStatus.success] with cached products when there is no internet connection but data is cached',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => false);
        when(mockProductRepository.getCachedProducts())
            .thenAnswer((_) async => productList);
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        ProductState(
          status: ProductsStatus.success,
          products: productList,
          hasReachedMax: true,
          productFetchLimit: productList.length,
          loadedFromCache: true,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductsStatus.failure] when there is no internet and no cached products',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => false);
        when(mockProductRepository.getCachedProducts())
            .thenAnswer((_) async => []);
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(status: ProductsStatus.failure),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductsStatus.failure] when repository throws an error',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenThrow(Exception('Error fetching products'));
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(status: ProductsStatus.failure),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductsStatus.success] when RetryProductFetched is triggered and fetch succeeds',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenAnswer((_) async => productList);
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(RetryProductFetched()),
      expect: () => [
        const ProductState(
            status: ProductsStatus.initial), // initial loading state
        const ProductState(
          status: ProductsStatus.success,
          products: productList,
          hasReachedMax: true,
          productFetchLimit: bigProductLimitStep,
          loadedFromCache: false,
        ),
      ],
    );
  });
  group('Fetch limit and maximum reached tests', () {
    blocTest<ProductBloc, ProductState>(
      'hasReachedMax is true when there are less products than is the limit',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenAnswer((_) async => productList);
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(
          status: ProductsStatus.success,
          products: productList,
          hasReachedMax: true,
          productFetchLimit: bigProductLimitStep,
          loadedFromCache: false,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'hasReachedMax is false when there are more products than is the limit',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenAnswer(
          (_) async => bigProductList,
        );
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      expect: () => [
        const ProductState(
          status: ProductsStatus.success,
          products: bigProductList,
          hasReachedMax: false,
          productFetchLimit: bigProductLimitStep,
          loadedFromCache: false,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'productFetchLimit grows with more responses',
      setUp: () {
        when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
        when(mockProductRepository.getProducts(limit: anyNamed('limit')))
            .thenAnswer(
          (_) async => productList,
        );
      },
      build: () => ProductBloc(
        repository: mockProductRepository,
        internetConnectionChecker: mockInternetConnectionChecker,
        throttleDuration: duration,
        productLimitStep: bigProductLimitStep,
      ),
      act: (bloc) => bloc.add(ProductFetched()),
      seed: () => const ProductState(productFetchLimit: bigProductLimitStep),
      expect: () => [
        const ProductState(
          status: ProductsStatus.success,
          products: productList,
          hasReachedMax: true,
          productFetchLimit: bigProductLimitStep * 2,
          loadedFromCache: false,
        ),
      ],
    );
  });
}
