import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.role,
  });
  final void Function() onTap;
  final bool isSelected;
  final String role;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 140.w,
        height: 180.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.black1 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColor.white : AppColor.black1,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.black1.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.w,
              color: isSelected ? AppColor.white : AppColor.black1,
            ),
            20.verticalSpace,
            Text(
              role,
              style: Styles.boldStyle(
                fontSize: 20.sp,
                color: isSelected ? AppColor.white : AppColor.black1,
                family: FontFamily.varela,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
