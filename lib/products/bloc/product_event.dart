part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductFetched extends ProductEvent {}

final class RetryProductFetched extends ProductEvent {}
