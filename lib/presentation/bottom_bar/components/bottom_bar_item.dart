import 'package:masla_bolo_app/presentation/search_issue/search_issue_page.dart';

import '../../home/home_screen.dart';
import '../../add_issue/create_issue_screen.dart';
import '../../notification/notification_page.dart';
import '../../profile/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../helpers/styles/app_images.dart';

class BottomBarItem {
  Widget page;
  String image;

  BottomBarItem({
    required this.image,
    required this.page,
  });
  static final userItems = [
    BottomBarItem(
      image: AppImages.homeGrey,
      page: const HomeScreen(),
    ),
    BottomBarItem(
      image: AppImages.search,
      page: const SearchIssuePage(),
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

  static final officialItems = [
    BottomBarItem(
      image: AppImages.homeGrey,
      page: const HomeScreen(),
    ),
    BottomBarItem(
      image: AppImages.search,
      page: const SearchIssuePage(),
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
