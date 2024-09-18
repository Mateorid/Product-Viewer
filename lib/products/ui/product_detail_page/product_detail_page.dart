import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/ui/common/page_template.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: 'Product Detail',
      body: Center(
        child: StarRating(rating: product.rating.rate),
      ),
    );
  }
}
