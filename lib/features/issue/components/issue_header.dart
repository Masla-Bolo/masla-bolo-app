import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/styles/styles.dart';

class IssueHeader extends StatelessWidget {
  const IssueHeader({super.key, required this.cubit});
  final IssueCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              cubit.goBack();
            },
            child: const Icon(Icons.arrow_back_ios_new, color: AppColor.black1),
          ),
          20.horizontalSpace,
          Text(
            "Create Issue",
            style: Styles.semiBoldStyle(
              fontSize: 30,
              color: AppColor.black1,
              family: FontFamily.dmSans,
            ),
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                cubit.showOptions(context);
              },
              child: Image.asset(AppImages.link)),
          5.horizontalSpace,
        ],
      ),
    );
  }
}
