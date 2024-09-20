import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_viewer/products/bloc/product_bloc.dart';
import 'package:product_viewer/products/repository/product_repository.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list_page.dart';
import 'package:product_viewer/util/ioc_container.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Viewer',
      theme: _buildThemeData(),
      home: BlocProvider(
        lazy: false,
        create: (_) => ProductBloc(repository: getIt<ProductRepository>())
          ..add(ProductFetched()),
        child: const SafeArea(child: ProductListPage()),
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
