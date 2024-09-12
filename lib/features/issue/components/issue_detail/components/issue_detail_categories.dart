import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../helpers/styles/app_colors.dart';
import '../../../../../helpers/styles/styles.dart';

class IssueDetailCategories extends StatelessWidget {
  const IssueDetailCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      direction: Axis.horizontal,
      children: [
        Chip(
            label: Text("Electric",
                style: Styles.boldStyle(
                  fontSize: 15,
                  color: AppColor.white,
                  family: FontFamily.varela,
                ))),
        Chip(
          label: Text(
            "Sewerage",
            style: Styles.boldStyle(
              fontSize: 15,
              color: AppColor.white,
              family: FontFamily.varela,
            ),
          ),
        ),
        Chip(
            label: Text("Street",
                style: Styles.boldStyle(
                  fontSize: 15,
                  color: AppColor.white,
                  family: FontFamily.varela,
                ))),
        Chip(
            label: Text("Broken",
                style: Styles.boldStyle(
                  fontSize: 15,
                  color: AppColor.white,
                  family: FontFamily.varela,
                ))),
        Chip(
            label: Text("Other",
                style: Styles.boldStyle(
                  fontSize: 15,
                  color: AppColor.white,
                  family: FontFamily.varela,
                ))),
      ],
    );
  }
}
