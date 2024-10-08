import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../helpers/styles/styles.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.tagLine,
    this.left = true,
  });
  final void Function() onTap;
  final bool left;
  final bool isSelected;
  final String title;
  final String tagLine;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 0.8.sw,
        height: 0.2.sh,
        decoration: BoxDecoration(
          color:
              isSelected ? context.colorScheme.onPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.onPrimary,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.colorScheme.onPrimary.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (left) ...[
              Icon(
                icon,
                size: 50.w,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onPrimary,
              ),
              20.horizontalSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                    Text(
                      tagLine,
                      style: Styles.boldStyle(
                        fontSize: 12,
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (!left) ...[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                    Text(
                      tagLine,
                      style: Styles.boldStyle(
                        fontSize: 12,
                        color: isSelected
                            ? context.colorScheme.primary
                            : context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                  ],
                ),
              ),
              20.horizontalSpace,
              Icon(
                icon,
                size: 50.w,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onPrimary,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
