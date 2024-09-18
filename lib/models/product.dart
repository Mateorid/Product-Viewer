import 'package:product_viewer/models/product_rating.dart';

class Product {
  final int id;
  final double price;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final ProductRating rating;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });
}
