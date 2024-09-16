import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

class GetStartedHeader extends StatelessWidget {
  const GetStartedHeader({
    super.key,
    this.onBackTap,
    this.hideBack = false,
    this.onNextTap,
    this.hideNext = false,
  });
  final bool hideBack;
  final void Function()? onBackTap;
  final bool hideNext;
  final void Function()? onNextTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          hideBack ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!hideBack)
          GestureDetector(
            onTap: onBackTap,
            child: Row(
              children: [
                10.horizontalSpace,
                const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColor.black1,
                  size: 16,
                ),
                5.horizontalSpace,
                Text(
                  "Back",
                  style: Styles.semiBoldStyle(
                    fontSize: 18,
                    color: AppColor.black1,
                    family: FontFamily.dmSans,
                  ),
                ),
              ],
            ),
          ),
        if (!hideNext)
          GestureDetector(
            onTap: onNextTap,
            child: Row(
              children: [
                Text(
                  "Next",
                  style: Styles.semiBoldStyle(
                    fontSize: 18,
                    color: AppColor.black1,
                    family: FontFamily.dmSans,
                  ),
                ),
                5.horizontalSpace,
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.black1,
                  size: 16,
                ),
                10.horizontalSpace,
              ],
            ),
          ),
      ],
    );
  }
}