import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/products_cubit.dart';
import 'package:product_viewer/products/ui/common/page_template.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: 'Product Viewer',
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          switch (state) {
            case ProductsLoaded loadedState:
              return ProductList(products: loadedState.response);
            case ProductsError errorState:
              // TODO: Display snack-bar and/or custom page?
              return Center(child: Text(errorState.error));
            case ProductsInitial():
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
