import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';

import '../../../di/service_locator.dart';
import '../auth_cubit.dart';
import '../auth_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static final authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        authCubit.goToLogin();
      },
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: state.signUpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        60.verticalSpace,
                        Center(
                          child: Text('MASLA BOLO!',
                              style: Styles.boldStyle(
                                fontSize: 30,
                                color: context.colorScheme.onPrimary,
                                family: FontFamily.dmSans,
                              )),
                        ),
                        10.verticalSpace,
                        Center(
                          child: Text(
                            'Report local issues & drive real change!',
                            style: Styles.mediumStyle(
                              fontSize: 16,
                              color: context.colorScheme.secondary,
                              family: FontFamily.varela,
                            ),
                          ),
                        ),
                        80.verticalSpace,
                        Text(
                          'Your user name',
                          style: Styles.boldStyle(
                            fontSize: 14,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        ),
                        10.verticalSpace,
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          onChanged: (val) {
                            state.user.username = val;
                          },
                          hintText: 'abcxyz456',
                        ),
                        15.verticalSpace,
                        Text(
                          'Your email address',
                          style: Styles.boldStyle(
                            fontSize: 14,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        ),
                        10.verticalSpace,
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'dlterragio@gmail.com',
                          onChanged: (val) {
                            state.user.email = val;
                          },
                        ),
                        15.verticalSpace,
                        Text(
                          'Create a password',
                          style: Styles.boldStyle(
                            fontSize: 14,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        ),
                        10.verticalSpace,
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (val) {
                            state.user.password = val;
                          },
                          passwordField: true,
                          hintText: 'min. 8 characters',
                        ),
                        20.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            loader(() => authCubit.register());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.onPrimary,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: Styles.mediumStyle(
                              fontSize: 12,
                              color: context.colorScheme.primary,
                              family: FontFamily.varela,
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        RichText(
                          text: TextSpan(
                              text: "  Already have an account? ",
                              style: Styles.mediumStyle(
                                fontSize: 12,
                                color: context.colorScheme.secondary,
                                family: FontFamily.varela,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      authCubit.goToLogin();
                                    },
                                  text: "Login",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: context.colorScheme.onPrimary,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
