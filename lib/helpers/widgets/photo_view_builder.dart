import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../styles/app_colors.dart';
import 'indicator.dart';

class PhotoViewBuilder extends StatelessWidget {
  const PhotoViewBuilder({
    super.key,
    required this.images,
    required this.onPageChanged,
    required this.pageController,
  });
  final PageController pageController;
  final List<String> images;
  final void Function(int index) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      enableRotation: false,
      backgroundDecoration: const BoxDecoration(
        color: AppColor.transparent,
      ),
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: pageController,
      onPageChanged: (index) {
        onPageChanged(index);
      },
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          basePosition: Alignment.center,
          heroAttributes: PhotoViewHeroAttributes(
            tag: '${images[index]}_$index',
            transitionOnUserGestures: true,
          ),
          filterQuality: FilterQuality.high,
          imageProvider: NetworkImage(images[index]),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.error_outline,
                size: 40.w,
              ),
            );
          },
        );
      },
      itemCount: images.length,
      loadingBuilder: (context, event) => const Center(
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: Indicator(),
        ),
      ),
    );
  }
}
