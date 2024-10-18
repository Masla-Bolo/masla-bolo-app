import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/di/service_locator.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/presentation/auth/auth_cubit.dart';
import 'package:masla_bolo_app/presentation/auth/auth_state.dart';
import 'package:masla_bolo_app/presentation/auth/verify_email/otp.dart';
import 'package:masla_bolo_app/presentation/auth/verify_email/otp_form.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/styles/styles.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, required this.email});
  final String email;

  static final authCubit = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        authCubit.goToRegister();
      },
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          authCubit.goToRegister();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      60.verticalSpace,
                      Center(
                        child: Text('Email Verification',
                            style: Styles.boldStyle(
                              fontSize: 30,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.dmSans,
                            )),
                      ),
                      10.verticalSpace,
                      Center(
                        child: Text(
                          "We sent your code to $email \nThis code will expired in 5:00",
                          textAlign: TextAlign.center,
                          style: Styles.mediumStyle(
                            fontSize: 16,
                            color: context.colorScheme.secondary,
                            family: FontFamily.varela,
                          ),
                        ),
                      ),
                      80.verticalSpace,
                      //coded field here
                      OtpForm(otps: [
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, email);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, email);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, email);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, email);
                        }),
                      ]),
                      20.verticalSpace,
                      ElevatedButton(
                        onPressed: state.verifyCode.length != 4 ||
                                state.verifyCode.isEmpty
                            ? null
                            : () {
                                loader(() => authCubit.verifyMyEmail(email));
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.onPrimary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Verify Email',
                          style: Styles.mediumStyle(
                            fontSize: 15,
                            color: context.colorScheme.primary,
                            family: FontFamily.varela,
                          ),
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
