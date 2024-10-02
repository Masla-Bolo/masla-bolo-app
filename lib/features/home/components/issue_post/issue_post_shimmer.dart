import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/widgets/shimmer_effect.dart';

import '../../../../helpers/helpers.dart';
import '../../../../helpers/styles/app_colors.dart';
import '../../../../helpers/widgets/scroll_shader_mask.dart';

class IssuePostShimmer extends StatelessWidget {
  const IssuePostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollShaderMask(
        child: ListView.separated(
          padding: scrollBottomPadding,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          separatorBuilder: (contex, index) {
            return Divider(
              color: Colors.grey.shade300,
              thickness: 7,
              height: 7,
            );
          },
          itemBuilder: (context, index) {
            return Container(
              color: AppColor.white,
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                        height: 200, width: 1.sw, child: const ShimmerEffect()),
                  ),
                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 0.025.sh,
                          width: 0.7.sw,
                          child: const ShimmerEffect(),
                        ),
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.thumb_up_alt_outlined,
                              color: AppColor.black1,
                            ),
                            SizedBox(
                              height: 0.015.sh,
                              width: 0.2.sw,
                              child: const ShimmerEffect(),
                            ),
                            5.horizontalSpace,
                            const Text("•"),
                            5.horizontalSpace,
                            const Icon(
                              Icons.comment_outlined,
                              color: AppColor.black1,
                            ),
                            SizedBox(
                              width: 0.2.sw,
                              height: 0.015.sh,
                              child: const ShimmerEffect(),
                            ),
                            5.horizontalSpace,
                            const Text("•"),
                            5.horizontalSpace,
                            SizedBox(
                              width: 0.2.sw,
                              height: 0.015.sh,
                              child: const ShimmerEffect(),
                            ),
                            5.horizontalSpace,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
