import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
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
        // gradient: LinearGradient(
        //   colors: [
        //     AppColor.black1.withOpacity(0.9),
        //     AppColor.navy.withOpacity(0.9),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        color: AppColor.black3,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColor.black1,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.boldStyle(
              fontSize: 24.sp,
              color: AppColor.white,
            ),
          ),
          10.verticalSpace,
          Text(
            subTitle,
            style: Styles.mediumStyle(
              fontSize: 16.sp,
              color: AppColor.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
