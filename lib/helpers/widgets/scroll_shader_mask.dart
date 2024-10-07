import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class ScrollShaderMask extends StatefulWidget {
  final Widget? child;
  final ScrollController? scrollController;
  final VoidCallback? callback;
  const ScrollShaderMask(
      {required this.child, super.key, this.scrollController, this.callback});

  @override
  State<ScrollShaderMask> createState() => _ScrollShaderMaskState();
}

class _ScrollShaderMaskState extends State<ScrollShaderMask> {
  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null && widget.callback != null) {
      widget.scrollController!.addListener(() {
        if (widget.scrollController?.hasClients ?? false) {
          if (widget.scrollController!.position.pixels >=
              widget.scrollController!.position.maxScrollExtent - 100) {
            widget.callback!();
          }
        }
      });
    }
  }

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
        controller: widget.scrollController,
        padding: EdgeInsets.only(top: 8.h),
        child: widget.child,
      ),
    );
  }
}
