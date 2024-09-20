import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_rating.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ProductRating extends Equatable {
  const ProductRating({
    required this.rate,
    required this.count,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingFromJson(json);
  @HiveField(0)
  final double rate;
  @HiveField(1)
  final int count;

  Map<String, dynamic> toJson() => _$ProductRatingToJson(this);

  @override
  List<Object?> get props => [rate, count];
}
