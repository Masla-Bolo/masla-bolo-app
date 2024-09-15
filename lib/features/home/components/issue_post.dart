import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/styles/styles.dart';

class IssuePost extends StatelessWidget {
  const IssuePost({super.key, required this.index, required this.cubit});
  final int index;
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              cubit.goToIssueDetail();
            },
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    index.isEven ? AppImages.temp : AppImages.sewerage,
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Row(
                    children: [
                      5.horizontalSpace,
                      const CircleAvatar(
                        backgroundColor: AppColor.white,
                        radius: 15,
                        child: Icon(Icons.person, color: AppColor.white),
                      ),
                      7.horizontalSpace,
                      Text(
                        "User Name",
                        style: Styles.boldStyle(
                          fontSize: 12,
                          color: AppColor.white,
                          family: FontFamily.varela,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.goToIssueDetail();
                  },
                  child: Text(
                    "So what makes a good headline?",
                    style: Styles.boldStyle(
                      fontSize: 15,
                      family: FontFamily.varela,
                      color: AppColor.black1,
                    ),
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.thumb_up_alt,
                      color: AppColor.black1,
                    ),
                    Text(
                      "5.1M Likes",
                      style: Styles.mediumStyle(
                          fontSize: 12,
                          color: AppColor.black1,
                          family: FontFamily.varela),
                    ),
                    5.horizontalSpace,
                    const Text("•"),
                    5.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        cubit.goToIssueDetail(showComment: true);
                      },
                      child: const Icon(
                        Icons.comment_outlined,
                        color: AppColor.black1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.goToIssueDetail(showComment: true);
                      },
                      child: Text(
                        "1.5k comments",
                        style: Styles.mediumStyle(
                            fontSize: 12,
                            color: AppColor.black1,
                            family: FontFamily.varela),
                      ),
                    ),
                    5.horizontalSpace,
                    const Text("•"),
                    5.horizontalSpace,
                    Text(
                      "1 Day ago",
                      style: Styles.mediumStyle(
                          fontSize: 12,
                          color: AppColor.black1,
                          family: FontFamily.varela),
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
  }
}
