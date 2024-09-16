import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class ScrollShaderMask extends StatelessWidget {
  final Widget? child;
  const ScrollShaderMask({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            AppColor.transparent,
            Theme.of(context).colorScheme.surface,
          ],
          stops: const [
            0.98,
            1,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 8.h),
        child: child,
      ),
    );
  }
}
