import 'package:masla_bolo_app/features/home/home_screen.dart';
import 'package:masla_bolo_app/features/notification/notification_page.dart';
import 'package:masla_bolo_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class BottomBarItem {
  Widget page;
  String title;
  String icon;

  BottomBarItem({
    required this.icon,
    required this.page,
    required this.title,
  });
  static final items = [
    BottomBarItem(
      icon: 'home',
      page: HomeScreen(cubit: getIt()),
      title: 'Home',
    ),
    BottomBarItem(
      icon: 'home',
      page: const NotificationPage(),
      title: 'Notifications',
    ),
    BottomBarItem(
      icon: 'You',
      page: const ProfileScreen(),
      title: 'You',
    ),
  ];
}
