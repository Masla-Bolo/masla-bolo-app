import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'shimmer_effect.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.image, this.borderRadius = 10});
  final String image;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.dst,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => const ShimmerEffect(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
