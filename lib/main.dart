import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_viewer/app_root.dart';
import 'package:product_viewer/util/helper_functions.dart';
import 'package:product_viewer/util/ioc_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initialiseHive();
  iocSetup();
  runApp(const AppRoot());
}
