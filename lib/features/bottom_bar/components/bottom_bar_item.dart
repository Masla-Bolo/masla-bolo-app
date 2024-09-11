import 'package:masla_bolo_app/features/home/home_screen.dart';
import 'package:masla_bolo_app/features/issue/issue_screen.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../main.dart';

class BottomBarItem {
  Widget page;
  String icon;

  BottomBarItem({
    required this.icon,
    required this.page,
  });
  static final items = [
    BottomBarItem(
      icon: AppImages.homeGrey,
      page: HomeScreen(cubit: getIt()),
    ),
    BottomBarItem(
      icon: AppImages.writeGrey,
      page: IssueScreen(cubit: getIt()),
    ),
    BottomBarItem(
      icon: AppImages.profileGrey,
      page: ProfileScreen(cubit: getIt()),
    )
  ];
}
