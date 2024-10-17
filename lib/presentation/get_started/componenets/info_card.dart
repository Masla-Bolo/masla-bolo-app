import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helpers/extensions.dart';

import '../../../helpers/styles/styles.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.subTitle, required this.title});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.boldStyle(
              fontSize: 24.sp,
              color: context.colorScheme.primary,
              family: FontFamily.dmSans,
            ),
          ),
          10.verticalSpace,
          Text(
            subTitle,
            style: Styles.mediumStyle(
              fontSize: 16.sp,
              family: FontFamily.varela,
              color: context.colorScheme.primary.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
