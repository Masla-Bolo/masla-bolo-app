import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';
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
            child: const Icon(Icons.arrow_back_ios_new, color: AppColor.black1),
          ),
        20.horizontalSpace,
        Text(
          title,
          style: Styles.semiBoldStyle(fontSize: 30, color: AppColor.black1),
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
