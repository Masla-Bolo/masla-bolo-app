import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

class OfficialVerification extends StatelessWidget {
  const OfficialVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        Divider(
          color: context.colorScheme.secondary,
          height: 2,
          thickness: 0.2,
        ),
        10.verticalSpace,
        Text(
          "COMPLETE YOUR PROFILE TO SOLVE ISSUES!",
          textAlign: TextAlign.center,
          style: Styles.boldStyle(
            fontSize: 20,
            color: context.colorScheme.onPrimary,
            family: FontFamily.varela,
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CSCPicker(
            disabledDropdownDecoration: BoxDecoration(
              color: context.colorScheme.primary,
              border: Border.all(
                color: context.colorScheme.onPrimary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            dropdownDecoration: BoxDecoration(
              color: context.colorScheme.primary,
              border: Border.all(
                color: context.colorScheme.onPrimary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            onCountryChanged: (value) {
              log("COUNTRY: $value");
            },
            onStateChanged: (value) {
              log("STATE: $value");
            },
            onCityChanged: (value) {
              log("CITY: $value");
            },
          ),
        ),
      ],
    );
  }
}
