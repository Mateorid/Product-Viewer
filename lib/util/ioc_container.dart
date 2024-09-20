import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:product_viewer/products/repository/http_product_repository.dart';
import 'package:product_viewer/products/repository/product_repository.dart';
import 'package:product_viewer/util/shared_constants.dart';

final getIt = GetIt.instance;

void iocSetup() {
  getIt
    ..registerSingleton<http.Client>(http.Client())
    ..registerSingleton<ProductRepository>(
      HttpProductRepository(
        client: getIt<http.Client>(),
        productBox: Hive.box(kProductKey),
      ),
    );
}
