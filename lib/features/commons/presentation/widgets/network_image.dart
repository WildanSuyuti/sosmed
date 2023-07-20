import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'shimmer_container.dart';

class ImageNetworkContainer extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? radius;

  const ImageNetworkContainer(
    this.path, {
    Key? key,
    this.width,
    this.height,
    this.boxFit,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 16),
      child: CachedNetworkImage(
        imageUrl: path ?? '',
        width: width,
        height: height,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (_, url) {
          return ShimmerContainer(
            child: Container(width: width, height: height, color: Colors.white),
          );
        },
        errorWidget: (_, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
