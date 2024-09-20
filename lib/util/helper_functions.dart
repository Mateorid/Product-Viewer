import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:product_viewer/products/models/product.dart';
import 'package:product_viewer/products/models/product_rating.dart';
import 'package:product_viewer/util/shared_constants.dart';
import 'package:stream_transform/stream_transform.dart';

/// Throttle events by given duration
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

Future<void> initialiseHive() async {
  //Register adapters
  Hive
    ..registerAdapter(ProductAdapter())
    ..registerAdapter(ProductRatingAdapter());
  //Open boxes
  await Hive.openBox<Product>(kProductKey);
}
