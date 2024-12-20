import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../helpers/extensions.dart';

import '../../../../helpers/styles/app_colors.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final adaptiveTheme = AdaptiveTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder(
            valueListenable: adaptiveTheme.modeChangeNotifier,
            builder: (context, theme, child) {
              return SizedBox(
                height: 0.06.sh,
                child: FlutterSwitch(
                  value: adaptiveTheme.mode.isDark,
                  padding: 4.0,
                  toggleColor: context.colorScheme.primary,
                  activeColor: context.colorScheme.secondary.withOpacity(0.1),
                  inactiveColor: AppColor.grey.withOpacity(0.15),
                  activeIcon: Icon(
                    Icons.dark_mode,
                    color: context.colorScheme.onPrimary,
                  ),
                  inactiveIcon: const Icon(
                    Icons.light_mode,
                    color: AppColor.mango,
                  ),
                  onToggle: (value) {
                    adaptiveTheme.setThemeMode(
                      value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
