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
                children: [
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 0.1.sh,
                      width: 0.2.sw,
                      child: Image.file(
                        File(file.path),
                        fit: BoxFit.contain,
                      )
                      // FutureBuilder<XFile?>(
                      //   future: _getThumbnail(file),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Indicator();
                      //     } else if (snapshot.hasError) {
                      //       return Center(
                      //           child: Text('Error: ${snapshot.error}'));
                      //     }
                      //     if (snapshot.hasData) {
                      //       return Image.file(
                      //         File(snapshot.data!.path),
                      //         fit: BoxFit.contain,
                      //       );
                      //     } else {
                      //       return Image.file(
                      //         File(file.path),
                      //         fit: BoxFit.contain,
                      //       );
                      //     }
                      //   },
                      // ),
                      ),
                  Positioned(
                    top: -4,
                    right: -5,
                    child: GestureDetector(
                      onTap: () {
                        onCrossTap.call(file);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: AppColor.red,
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

  // Future<XFile?> _getThumbnail(XFile file) async {
  //   if ((file.name.endsWith('mp4'))) {
  //     final thumbnail = await VideoThumbnail.thumbnailFile(
  //       video: file.path,
  //       imageFormat: ImageFormat.PNG,
  //       maxWidth: 128,
  //       quality: 75,
  //     );
  //     return thumbnail;
  //   }
  //   return null;
  // }
}
