import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';

class AppNotificationSettings extends StatelessWidget {
  const AppNotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            AppNavigation.navigatorKey.currentState?.pop();
          },
          child: Icon(Icons.arrow_back_ios_new,
              size: 20, color: context.colorScheme.onPrimary),
        ),
        title: Text(
          'Notification Settings',
          style: Styles.boldStyle(
            color: context.colorScheme.onPrimary,
            fontSize: 22,
            family: FontFamily.varela,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingItem(
              context,
              title: "Push Notifications",
              description: "Receive notifications for updates and alerts.",
              value: true,
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            _buildSettingItem(
              context,
              title: "Email Notifications",
              description: "Get email updates for new messages.",
              value: false,
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            _buildSettingItem(
              context,
              title: "New Content Alerts",
              description: "Be notified when new content is added.",
              value: true,
              onChanged: (val) {},
            ),
            const SizedBox(height: 20),
            _buildSettingItem(
              context,
              title: "Sound Alerts",
              description: "Enable sound for incoming notifications.",
              value: false,
              onChanged: (val) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.boldStyle(
                  fontSize: 18,
                  family: FontFamily.varela,
                  color: context.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: Styles.mediumStyle(
                  family: FontFamily.varela,
                  fontSize: 14,
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: context.colorScheme.onPrimary,
          thumbColor: context.colorScheme.primary,
        ),
      ],
    );
  }
}
