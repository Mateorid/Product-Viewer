import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_viewer/app_root.dart';
import 'package:product_viewer/util/hive_initialiser.dart';

void main() async {
  // TODO have a internet connection cubit with snack-bar/toast on no internet - create a new state for when the data was retrieved from cache and have extra switch case which just triggers the toast
  // TODO Pagination?
  // TODO tests

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initialiseHive();
  runApp(const AppRoot());
}
