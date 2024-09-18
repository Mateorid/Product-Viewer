import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/products_cubit.dart';
import 'package:product_viewer/products/repository/http_product_repository.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list_page.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        lazy: false,
        create: (context) =>
            ProductsCubit(productRepository: HttpProductRepository()),
        child: SafeArea(child: const ProductListPage()),
      ),
    );
  }
}
