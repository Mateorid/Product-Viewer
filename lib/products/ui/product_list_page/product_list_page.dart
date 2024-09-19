import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/products/ui/common/page_template.dart';
import 'package:product_viewer/products/ui/product_list_page/connection_error_display.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: 'Product Viewer',
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case ProductsStatus.success:
              return ProductList(
                products: state.products,
                hasReachedMax: state.hasReachedMax,
              );
            case ProductsStatus.failure:
              return Center(child: ConnectionErrorDisplay());
          }
        },
      ),
    );
  }
}
