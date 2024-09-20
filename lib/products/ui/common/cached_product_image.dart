import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedProductImage extends StatelessWidget {
  const CachedProductImage({required this.imageUrl, super.key});
  final String imageUrl;

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
          const Icon(Icons.signal_wifi_connected_no_internet_4_outlined),
    );
  }
}
