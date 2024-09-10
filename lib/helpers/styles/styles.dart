import 'package:flutter/material.dart';

import 'app_colors.dart';

class Styles {
  static InputDecoration inputFieldDecoration(
      String hintText, BuildContext context,
      {Widget? suffixIcon, TextStyle? hintStyle}) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      fillColor: AppColor.lightGrey,
      errorStyle: boldStyle(fontSize: 12, color: AppColor.red),
      errorBorder: InputBorder.none,
      errorMaxLines: 1,
      contentPadding: const EdgeInsets.all(8),
      focusedErrorBorder: InputBorder.none,
      hintStyle: hintStyle ?? mediumStyle(fontSize: 12, color: AppColor.black1),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColor.black1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColor.black1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  static TextStyle boldStyle({required double fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle semiBoldStyle(
      {required double fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle mediumStyle(
      {required double fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle semiMediumStyle(
      {required double fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle lightStyle(
      {required double fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: fontSize,
      color: color,
    );
  }

  static ColorScheme scheme(BuildContext context) {
    return Theme.of(context).colorScheme;
  }
}
