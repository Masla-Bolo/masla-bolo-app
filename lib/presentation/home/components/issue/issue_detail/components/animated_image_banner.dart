import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../../../../../helpers/widgets/photo_silder.dart';
import '../../../../../../helpers/widgets/rounded_image.dart';

class AnimatedImageBanner extends StatefulWidget {
  const AnimatedImageBanner({
    super.key,
    required this.issue,
    required this.index,
  });
  final IssueEntity issue;
  final int index;
  @override
  State<AnimatedImageBanner> createState() => _AnimatedImageBannerState();
}

class _AnimatedImageBannerState extends State<AnimatedImageBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          title: Row(
            children: [
              RoundedImage(
                imageUrl: widget.issue.user.image,
                iconText: widget.issue.user.username,
                radius: 13.w,
              ),
              10.horizontalSpace,
              Text(
                widget.issue.title,
                style: Styles.mediumStyle(
                  fontSize: 14,
                  color: context.colorScheme.onPrimary,
                  family: FontFamily.dmSans,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 1.sw,
            child: PhotoSlider(
              images: widget.issue.images,
              index: widget.index,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                _controller.reverse();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
