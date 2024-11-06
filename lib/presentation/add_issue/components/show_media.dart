import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';

class ShowMedia extends StatelessWidget {
  const ShowMedia({
    super.key,
    required this.media,
    required this.onCrossTap,
  });

  final List<XFile> media;
  final void Function(XFile file) onCrossTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: media.map((file) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 0.1.sh,
                      width: 0.3.sw,
                      child: Image.file(
                        File(file.path),
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {
                          onCrossTap.call(file);
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: AppColor.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
