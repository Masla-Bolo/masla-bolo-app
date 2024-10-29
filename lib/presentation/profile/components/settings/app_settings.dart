import 'package:flutter/material.dart';
import 'package:masla_bolo_app/navigation/route_name.dart';

class AppSettings {
  IconData icon;
  String title;
  String routeName;
  AppSettings({
    required this.routeName,
    required this.icon,
    required this.title,
  });

  static final appSettings = [
    AppSettings(
      routeName: RouteName.aboutUs,
      icon: Icons.description,
      title: "About Us",
    ),
    AppSettings(
      routeName: RouteName.notificationSettings,
      icon: Icons.notifications_active_outlined,
      title: "Notification",
    ),
    AppSettings(
      routeName: RouteName.privacyPolicy,
      icon: Icons.privacy_tip_outlined,
      title: "Privacy Policy",
    ),
    AppSettings(
      routeName: RouteName.developers,
      icon: Icons.code,
      title: "Developers",
    ),
    AppSettings(
      routeName: RouteName.contactUs,
      icon: Icons.mail_outline,
      title: "Contact Us",
    ),
    AppSettings(
      routeName: RouteName.supportUs,
      icon: Icons.handshake_outlined,
      title: "Support Us",
    ),
  ];
}
