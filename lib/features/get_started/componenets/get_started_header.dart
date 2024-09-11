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
      children: [
        if (!hideBack) ...[
          10.horizontalSpace,
          GestureDetector(
            onTap: onBackTap,
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColor.black1,
              size: 16,
            ),
          ),
          5.horizontalSpace,
          Text(
            "Back",
            style: Styles.semiBoldStyle(fontSize: 18, color: AppColor.black1),
          ),
        ],
        if (!hideNext) ...[
          const Spacer(),
          Text(
            "Next",
            style: Styles.semiBoldStyle(fontSize: 18, color: AppColor.black1),
          ),
          5.horizontalSpace,
          GestureDetector(
            onTap: onNextTap,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.black1,
              size: 16,
            ),
          ),
          10.horizontalSpace,
        ],
      ],
    );
  }
}
