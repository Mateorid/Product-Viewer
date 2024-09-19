import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_viewer/products/bloc/products_cubit.dart';
import 'package:product_viewer/products/repository/http_product_repository.dart';
import 'package:product_viewer/products/ui/product_list_page/product_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:product_viewer/util/shared_constants.dart';

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
        create: (context) => ProductsCubit(
          //TODO move to DI?
          productRepository: HttpProductRepository(
            client: http.Client(),
            productBox: Hive.box(kProductKey),
          ),
        ),
        child: SafeArea(child: const ProductListPage()),
      ),
    );
  }
}
