import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/ui/common/cached_product_image.dart';
import 'package:product_viewer/products/ui/common/page_template.dart';
import 'package:product_viewer/util/shared_constants.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PageTemplate(
      pageTitle: 'Product Detail',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kSmallGap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title, style: textTheme.headlineLarge),
              const SizedBox.square(dimension: kSmallGap),
              _buildStarRating(textTheme),
              const SizedBox.square(dimension: kSmallGap),
              Text('\$${product.price}', style: textTheme.headlineSmall),
              const SizedBox.square(dimension: kNormalGap),
              _buildProductImage(),
              const SizedBox.square(dimension: kNormalGap),
              Text(product.description, style: textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating(TextTheme textTheme) {
    return Row(
      children: [
        StarRating(rating: product.rating.rate),
        const SizedBox.square(dimension: kSmallGap),
        Text('${product.rating.count}x', style: textTheme.bodyMedium)
      ],
    );
  }

  Widget _buildProductImage() {
    return Center(
      child: SizedBox.square(
        dimension: 250,
        child: CachedProductImage(imageUrl: product.imageUrl),
      ),
    );
  }
}
