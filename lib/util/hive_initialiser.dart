import 'package:hive/hive.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/models/product_rating.dart';
import 'package:product_viewer/util/shared_constants.dart';

Future<void> initialiseHive() async {
  //Register adapters
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ProductRatingAdapter());
  //Open boxes
  await Hive.openBox<Product>(kProductKey);
}
