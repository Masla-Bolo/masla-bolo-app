import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

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
        if (!hideBackIcon) ...[
          10.horizontalSpace,
          GestureDetector(
            onTap: onBackTap,
            child: Icon(Icons.arrow_back_ios_new,
                size: 15, color: context.colorScheme.onPrimary),
          ),
        ],
        20.horizontalSpace,
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: context.colorScheme.onPrimary,
              fontFamily: "dmSans",
              overflow: TextOverflow.ellipsis,
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
