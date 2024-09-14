import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../helpers/widgets/header.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Header(
                title: "Notifications",
                onBackTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Spacer(),
            Text(
              'NOTIFICATION SCREEN IN PROCESS',
              style: Styles.boldStyle(
                fontSize: 20,
                color: AppColor.black1,
                family: FontFamily.dmSans,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
