import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../../domain/entities/issue_entity.dart';
import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key, required this.issues});
  final List<IssueEntity> issues;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: issues.length,
        padding: scrollBottomPadding,
        itemBuilder: (context, index) {
          final issue = issues[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.lightGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                title: Text(
                  issue.title,
                  style: Styles.boldStyle(
                    family: FontFamily.varela,
                    fontSize: 16,
                    color: AppColor.black1,
                  ),
                ),
                subtitle: Text(
                  issue.description,
                  style: Styles.boldStyle(
                    family: FontFamily.varela,
                    fontSize: 16,
                    color: AppColor.black1,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
