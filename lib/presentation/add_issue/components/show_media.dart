import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
          children: media.map((image) {
            return Stack(
              children: [
                SizedBox(
                  height: 0.2.sh,
                  width: 0.4.sw,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Image.file(File(image.path)),
                  ),
                ),
                Positioned(
                  top: -2,
                  right: 1,
                  child: GestureDetector(
                      onTap: () {
                        onCrossTap.call(image);
                      },
                      child: const Icon(Icons.cancel)),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
