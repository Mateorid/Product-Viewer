import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/common/shared_ui_constants.dart';
import 'package:product_viewer/products/bloc/products_cubit.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/ui/product_detail_page/product_detail_page.dart';
import 'package:product_viewer/products/ui/product_list_page/product_tile.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('No products to display'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSmallGap),
      //todo test on mobile
      child: RefreshIndicator(
        onRefresh: context.read<ProductsCubit>().getProducts,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductTile(
              product: product,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
            );
          },
          separatorBuilder: (_, __) =>
              const SizedBox.square(dimension: kNormalGap),
        ),
      ),
    );
  }
}
