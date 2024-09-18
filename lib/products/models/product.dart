import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

// Extending Equatable to avoid unnecessary re-building (Overrides `==` & `hashCode`)
@JsonSerializable()
class Product extends Equatable {
  final int id;
  final double price;
  final String title;
  final String description;
  @JsonKey(name: 'image')
  final String imageUrl;
  final String category;
  // final ProductRating rating;

  // TODO remove or implement rating
  const Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    // required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props =>
      [id, price, title, description, imageUrl, category];
}
