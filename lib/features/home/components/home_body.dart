import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColor.black1,
        backgroundColor: AppColor.white,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 80, top: 10),
          itemCount: 10,
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
                  Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          AppImages.temp,
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
                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Column(
                      children: [
                        const Text(
                            "THIS IS THE TITLE THIS IS THE TITLE THIS IS THE TITLE THIS IS THE TITLE"),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: AppColor.red,
                            ),
                            const Text("5.1M Likes"),
                            5.horizontalSpace,
                            const Text("•"),
                            5.horizontalSpace,
                            const Icon(
                              Icons.comment_outlined,
                              color: AppColor.lightGrey,
                            ),
                            const Text("1.5k comments"),
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
          },
        ),
      ),
    );
  }
}
