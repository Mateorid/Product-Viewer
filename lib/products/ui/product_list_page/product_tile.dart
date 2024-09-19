import 'package:flutter/material.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/ui/common/cached_product_image.dart';
import 'package:product_viewer/util/shared_constants.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final void Function() onTap;
  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(kM3CardRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(kSmallGap),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: 100,
                child: CachedProductImage(imageUrl: product.imageUrl),
              ),
              const SizedBox.square(dimension: kSmallGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.title}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        //todo clean
                        // fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    //todo clean
                    // Text(
                    //   '${product.description}',
                    //   maxLines: 3,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //     fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
