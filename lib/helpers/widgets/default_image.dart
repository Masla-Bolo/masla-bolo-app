import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../styles/app_colors.dart';

class DefaultImage extends StatelessWidget {
  final String? text;
  final double size;
  final double? borderRadius;
  final bool showBorder;
  final Color? color;
  const DefaultImage({
    super.key,
    this.color,
    this.text,
    this.size = 45,
    this.borderRadius,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? size),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? size),
          border: showBorder
              ? Border.all(
                  width: 2,
                  color: color ?? context.colorScheme.secondary,
                )
              : null,
        ),
        child: Center(
          child: Text(
            (text?.split(' ').map((word) => word[0]).join().toUpperCase() ??
                ''),
            style: TextStyle(
              fontSize: size / 2.5,
              color: color ?? context.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
