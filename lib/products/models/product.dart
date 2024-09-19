import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:product_viewer/products/models/product_rating.dart';

part 'product.g.dart';

// Extending Equatable to avoid unnecessary re-building (Overrides `==` & `hashCode`)
@JsonSerializable()
@HiveType(typeId: 1)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  @JsonKey(name: 'image')
  final String imageUrl;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final ProductRating rating;

  const Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props =>
      [id, price, title, description, imageUrl, category, rating];
}
