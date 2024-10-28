import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../create_issue_cubit.dart';
import '../../../helpers/extensions.dart';

import '../../../helpers/styles/app_images.dart';
import '../../../helpers/styles/styles.dart';

class IssueHeader extends StatelessWidget {
  const IssueHeader({super.key, required this.cubit});
  final CreateIssueCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 0.07.sh,
      floating: true,
      pinned: true,
      title: Text(
        "Create Issue",
        style: Styles.semiBoldStyle(
          fontSize: 30,
          color: context.colorScheme.onPrimary,
          family: FontFamily.dmSans,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                cubit.getImages();
              },
              child: Image.asset(
                AppImages.link,
                color: context.colorScheme.onPrimary,
              )),
        ),
      ],
    );
  }
}
