import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/issue/components/issue_post.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../../helpers/styles/app_colors.dart';

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
          padding: scrollBottomPadding,
          itemCount: 10,
          separatorBuilder: (contex, index) {
            return Divider(
              color: Colors.grey.shade300,
              thickness: 7,
              height: 7,
            );
          },
          itemBuilder: (context, index) {
            return IssuePost(index: index);
          },
        ),
      ),
    );
  }
}
