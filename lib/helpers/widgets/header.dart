import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.onBackTap,
    required this.title,
    this.suffix,
    this.fontSize,
    this.hideBackIcon = false,
  });
  final double? fontSize;
  final String title;
  final Widget? suffix;
  final bool hideBackIcon;
  final void Function()? onBackTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!hideBackIcon) ...[
          10.horizontalSpace,
          GestureDetector(
            onTap: onBackTap,
            child: Icon(Icons.arrow_back_ios_new,
                size: fontSize ?? 15, color: context.colorScheme.onPrimary),
          ),
        ],
        20.horizontalSpace,
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSize ?? 15,
              color: context.colorScheme.onPrimary,
              fontFamily: "dmSans",
            ),
          ),
        ),
        if (suffix != null) ...[
          const Spacer(),
          suffix!,
          10.horizontalSpace,
        ],
      ],
    );
  }
}
