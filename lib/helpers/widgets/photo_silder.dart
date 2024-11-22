import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/widgets/photo_view_builder.dart';

class PhotoSlider extends StatefulWidget {
  const PhotoSlider({
    super.key,
    required this.images,
    required this.index,
  });
  final List<String> images;
  final int index;

  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.index;
    pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        16.verticalSpace,
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0.7.sh,
              minHeight: 0.3.sh,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: PhotoViewBuilder(
                      images: widget.images,
                      onPageChanged: (index) {
                        setState(() => currentPage = index);
                      },
                      pageController: pageController,
                    ),
                  ),
                  if (widget.images.length > 1) ...[
                    Positioned.fill(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: currentPage > 0
                                ? () {
                                    pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                : null,
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: currentPage < widget.images.length - 1
                                ? () {
                                    pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (widget.images.length > 1) ...[
          12.verticalSpace,
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  width: 8.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? context.colorScheme.onPrimary
                        : context.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
