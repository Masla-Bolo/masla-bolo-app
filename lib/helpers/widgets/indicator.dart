import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.isDark ? Colors.white : Colors.black,
      ),
    );
  }
}
