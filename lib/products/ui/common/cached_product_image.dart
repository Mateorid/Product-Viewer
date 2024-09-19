import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedProductImage extends StatelessWidget {
  final String imageUrl;

  const CachedProductImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(image: DecorationImage(image: imageProvider)),
      ),
      progressIndicatorBuilder: (_, __, dp) =>
          CircularProgressIndicator(value: dp.progress),
      errorWidget: (_, __, ___) =>
          Icon(Icons.signal_wifi_connected_no_internet_4_outlined),
    );
  }
}
