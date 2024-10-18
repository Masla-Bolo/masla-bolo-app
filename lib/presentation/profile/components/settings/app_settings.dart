import 'package:flutter/material.dart';

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
      routeName: "",
      icon: Icons.handshake_outlined,
      title: "Support Us",
    ),
    AppSettings(
      routeName: "",
      icon: Icons.notifications_active_outlined,
      title: "Notification",
    ),
    AppSettings(
      routeName: "",
      icon: Icons.privacy_tip_outlined,
      title: "Privacy Policy",
    ),
    AppSettings(
      routeName: "",
      icon: Icons.code,
      title: "Developers",
    ),
    AppSettings(
      routeName: "",
      icon: Icons.mail_outline,
      title: "Contact Us",
    ),
  ];
}
