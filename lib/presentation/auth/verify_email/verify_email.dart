import 'package:flutter/gestures.dart';
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

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.email});
  final String email;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final authCubit = getIt<AuthCubit>();

  @override
  void initState() {
    super.initState();
    authCubit.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        authCubit.exitEmailVerification();
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
                      20.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          authCubit.exitEmailVerification();
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
                          "We sent your code to ${widget.email} \nThis code will expire in 5:00 minutes",
                          textAlign: TextAlign.center,
                          style: Styles.mediumStyle(
                            fontSize: 16,
                            color: context.colorScheme.secondary,
                            family: FontFamily.varela,
                          ),
                        ),
                      ),
                      80.verticalSpace,
                      OtpForm(otps: [
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, widget.email, 0);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, widget.email, 1);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, widget.email, 2);
                        }),
                        Otp(onChanged: (pin) {
                          authCubit.checkPinCompletion(pin, widget.email, 3);
                        }),
                      ]),
                      20.verticalSpace,
                      ElevatedButton(
                        onPressed: state.otpCodes.length != 4
                            ? null
                            : () {
                                loader(
                                  () => authCubit.verifyMyEmail(widget.email),
                                  indicatorColor: context.colorScheme.primary,
                                );
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
                      RichText(
                        text: TextSpan(
                          text: !state.canResend
                              ? "Haven't received a code yet? Resend code in ${state.timeLeft}"
                              : "Haven't received a code yet? ",
                          style: Styles.mediumStyle(
                            fontSize: 12,
                            color: context.colorScheme.secondary,
                            family: FontFamily.varela,
                          ),
                          children: [
                            if (state.canResend)
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    authCubit.startTimer(
                                        startAgain: true, email: widget.email);
                                  },
                                text: "Resend Code",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: context.colorScheme.onPrimary,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                          ],
                        ),
                      ),
                      15.verticalSpace,
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
