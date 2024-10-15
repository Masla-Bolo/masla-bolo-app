import 'package:masla_bolo_app/features/like_issue/like_issue_page.dart';
import 'package:masla_bolo_app/features/home/home_screen.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

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
      page: const HomeScreen(),
    ),
    BottomBarItem(
      image: AppImages.heart,
      page: const LikeIssuePage(),
    ),
    BottomBarItem(
      image: AppImages.writeGrey,
      page: const CreateIssueScreen(),
    ),
    BottomBarItem(
      image: AppImages.bell,
      page: const NotificationPage(),
    ),
    BottomBarItem(
      image: AppImages.profileGrey,
      page: const ProfileScreen(),
    )
  ];
}
