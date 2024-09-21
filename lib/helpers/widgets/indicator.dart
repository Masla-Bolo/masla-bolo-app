import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        // color: context.isDark ? Colors.white : Colors.black,
        color: AppColor.black1,
      ),
    );
  }
}
