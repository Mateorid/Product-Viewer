import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/products_cubit.dart';
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
    //Todo wrap with page template
    return Scaffold(
      appBar: AppBar(title: Text('Product Viewer'), centerTitle: true),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          switch (state) {
            case ProductsLoaded loaded:
              return ProductList(products: loaded.response);
            case ProductsError e:
              // TODO: Display snackbar or custom page?
              return Center(child: Text(e.error));
            case ProductsInitial():
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    // TODO GRID! - proste to co se rozlozi tak at se toho tam vleze co nejvic
  }
}
