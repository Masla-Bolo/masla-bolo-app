import 'package:masla_bolo_app/features/like_issue/like_issue_page.dart';
import 'package:masla_bolo_app/features/home/home_screen.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../service/app_service.dart';

class BottomBarItem {
  Widget page;
  String image;

  BottomBarItem({
    required this.image,
    required this.page,
  });
  static final items = [
    BottomBarItem(
      image: AppImages.homeGrey,
      page: HomeScreen(cubit: getIt()),
    ),
    BottomBarItem(
      image: AppImages.heart,
      page: LikeIssuePage(cubit: getIt()),
    ),
    BottomBarItem(
      image: AppImages.writeGrey,
      page: CreateIssueScreen(cubit: getIt()),
    ),
    BottomBarItem(
      image: AppImages.bell,
      page: NotificationPage(cubit: getIt()),
    ),
    BottomBarItem(
      image: AppImages.profileGrey,
      page: ProfileScreen(cubit: getIt()),
    )
  ];
}
