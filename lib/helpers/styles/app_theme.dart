import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const lightColortheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.black1,
    onPrimary: AppColor.black1,
    secondary: AppColor.black1,
    onSecondary: AppColor.black1,
    error: AppColor.black1,
    onError: AppColor.black1,
    surface: AppColor.black1,
    onSurface: AppColor.black1,
  );

  static const darkColortheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.black1,
    onPrimary: AppColor.black1,
    secondary: AppColor.black1,
    onSecondary: AppColor.black1,
    error: AppColor.black1,
    onError: AppColor.black1,
    surface: AppColor.black1,
    onSurface: AppColor.black1,
  );

  static ThemeData theme({bool dark = false}) {
    return ThemeData(
      scaffoldBackgroundColor: dark ? AppColor.black6 : AppColor.white,
      useMaterial3: true,
      colorScheme: dark ? darkColortheme : lightColortheme,
      fontFamily: 'SFPro',
      textTheme: dark ? Typography.whiteCupertino : Typography.blackCupertino,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
