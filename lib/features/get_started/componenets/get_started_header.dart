import 'package:flutter/material.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

class GetStartedHeader extends StatelessWidget {
  const GetStartedHeader({
    super.key,
    this.onBackTap,
    this.hideBack = false,
    this.onNextTap,
    this.hideNext = false,
  });
  final bool hideBack;
  final void Function()? onBackTap;
  final bool hideNext;
  final void Function()? onNextTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          hideBack ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!hideBack)
          GestureDetector(
            onTap: onBackTap,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: context.colorScheme.onPrimary,
              size: 20,
            ),
          ),
        if (!hideNext)
          GestureDetector(
            onTap: onNextTap,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: context.colorScheme.onPrimary,
              size: 20,
            ),
          ),
      ],
    );
  }
}
