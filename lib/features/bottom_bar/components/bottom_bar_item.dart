import 'package:masla_bolo_app/features/home/home_screen.dart';
import 'package:masla_bolo_app/features/issue/create_issue_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../service/app_service.dart';

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
      page: CreateIssueScreen(cubit: getIt()),
    ),
    BottomBarItem(
      icon: AppImages.bell,
      page: NotificationPage(cubit: getIt()),
    ),
    BottomBarItem(
      icon: AppImages.profileGrey,
      page: ProfileScreen(cubit: getIt()),
    )
  ];
}
