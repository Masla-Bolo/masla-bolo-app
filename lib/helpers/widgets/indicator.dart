import 'package:flutter/material.dart';
import '../extensions.dart';
import '../styles/app_colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.isDark ? AppColor.white : AppColor.darkBlue,
      ),
    );
  }
}
