import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_rating.g.dart';

@JsonSerializable()
class ProductRating extends Equatable {
  final double rate;
  final int count;

  ProductRating({
    required this.rate,
    required this.count,
  });
  factory ProductRating.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingToJson(this);

  @override
  List<Object?> get props => [rate, count];
}
