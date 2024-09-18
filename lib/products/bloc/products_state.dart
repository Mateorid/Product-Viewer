part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  ProductsLoaded({required this.response});

  final List<Product> response;
}

final class ProductsError extends ProductsState {
  ProductsError({required this.error});

  final String error;
}
