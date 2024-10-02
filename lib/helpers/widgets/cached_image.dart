import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'shimmer_effect.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
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
