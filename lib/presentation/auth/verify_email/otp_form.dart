import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import 'otp.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, required this.otps});
  final List<Otp> otps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: otps.map((otp) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: SizedBox(
            height: 0.1.sh,
            width: 0.12.sw,
            child: TextFormField(
              onChanged: (pin) {
                otp.onChanged!(pin);
                if (pin.isNotEmpty) {
                  FocusScope.of(context).nextFocus();
                }
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: Styles.semiMediumStyle(
                fontSize: 15,
                color: context.colorScheme.onPrimary,
                family: FontFamily.varela,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: Styles.mediumStyle(
                    fontSize: 15,
                    color: AppColor.grey,
                    family: FontFamily.varela,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: context.colorScheme.secondary),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                        color: context.colorScheme.onPrimary,
                      ))),
            ),
          ),
        );
      }).toList(),
    );
  }
}
