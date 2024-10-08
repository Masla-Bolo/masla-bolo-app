import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const lightColortheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.white,
    onPrimary: AppColor.black1,
    secondary: AppColor.lightGrey,
    onSecondary: AppColor.lightWhite,
    error: AppColor.red,
    onError: AppColor.white,
    surface: AppColor.lightWhite,
    onSurface: AppColor.black1,
  );

  static const darkColortheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColor.black1,
    onPrimary: AppColor.white,
    secondary: AppColor.lightGrey,
    onSecondary: AppColor.black3,
    error: AppColor.red,
    onError: AppColor.white,
    surface: AppColor.black2,
    onSurface: AppColor.lightGrey,
  );

  static ThemeData theme({bool dark = false}) {
    return ThemeData(
      scaffoldBackgroundColor: dark ? AppColor.black1 : AppColor.white,
      useMaterial3: true,
      colorScheme: dark ? darkColortheme : lightColortheme,
      fontFamily: "Varela",
      textTheme: dark ? Typography.whiteCupertino : Typography.blackCupertino,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
