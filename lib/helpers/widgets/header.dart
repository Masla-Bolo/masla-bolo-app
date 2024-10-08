import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../styles/styles.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.onBackTap,
    required this.title,
    this.suffix,
    this.hideBackIcon = false,
  });
  final String title;
  final Widget? suffix;
  final bool hideBackIcon;
  final void Function()? onBackTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!hideBackIcon)
          GestureDetector(
            onTap: onBackTap,
            child: Icon(Icons.arrow_back_ios_new,
                color: context.colorScheme.onPrimary),
          ),
        20.horizontalSpace,
        Text(
          title,
          style: Styles.semiBoldStyle(
            fontSize: 30,
            color: context.colorScheme.onPrimary,
            family: FontFamily.dmSans,
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
