import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../helpers/styles/app_images.dart';

class IssueDetailSlider extends StatelessWidget {
  const IssueDetailSlider({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 0.45.sh,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              // final image = product.images[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                      height: 0.45.sh,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Image.asset(
                          AppImages.sewerage,
                        ),
                        // CachedNetworkImage(
                        //   imageUrl: image,
                        //   imageBuilder: (context, imageProvider) =>
                        //       Container(
                        //     decoration: BoxDecoration(
                        //       color:
                        //           Theme.of(context).colorScheme.onPrimary,
                        //       image: DecorationImage(
                        //         image: imageProvider,
                        //         fit: BoxFit.cover,
                        //         colorFilter: ColorFilter.mode(
                        //           Theme.of(context).colorScheme.onPrimary,
                        //           BlendMode.dst,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   placeholder: (context, url) =>
                        //       const ShimmerEffect(),
                        //   errorWidget: (context, url, error) =>
                        //       const Icon(Icons.error),
                        // ),
                      )),
                ),
              );
            }));
  }
}
