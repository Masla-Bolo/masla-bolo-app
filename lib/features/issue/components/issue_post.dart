import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/styles/styles.dart';

class IssuePost extends StatelessWidget {
  const IssuePost({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    index.isEven ? AppImages.temp : AppImages.test,
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
                            fontSize: 12, color: AppColor.white),
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
                  onTap: () {},
                  child: Text(
                    "So what makes a good headline?",
                    style: Styles.boldStyle(
                      fontSize: 15,
                      color: AppColor.black1,
                    ),
                  ),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.favorite,
                        color: AppColor.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("5.1M Likes"),
                    ),
                    5.horizontalSpace,
                    const Text("•"),
                    5.horizontalSpace,
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.comment_outlined,
                        color: AppColor.lightGrey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("1.5k comments"),
                    ),
                    5.horizontalSpace,
                    const Text("•"),
                    5.horizontalSpace,
                    const Text("1 Day ago"),
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
