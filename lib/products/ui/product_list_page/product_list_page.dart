import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/products/ui/common/page_template.dart';
import 'package:product_viewer/products/ui/product_list_page/connection_error_display.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list.dart';
import 'package:toastification/toastification.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      pageTitle: 'Product Viewer',
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) {
          switch (state.status) {
            case ProductsStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case ProductsStatus.success:
              if (state.loadedFromCache && context.mounted)
                _showCacheWarningToast(context);
              return ProductList(
                products: state.products,
                allProductsLoaded: state.hasReachedMax,
              );
            case ProductsStatus.failure:
              return Center(child: ConnectionErrorDisplay());
          }
        },
      ),
    );
  }

  void _showCacheWarningToast(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => toastification.show(
        context: context,
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        title: Text("No internet connection"),
        description: Text(
            "Results were loaded from cache.\nSome results might be missing"),
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(12.0),
        dragToClose: true,
        applyBlurEffect: true,
      ),
    );
  }
}
