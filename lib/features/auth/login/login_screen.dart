import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/header.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';

import '../auth_cubit.dart';
import '../auth_state.dart';

class LoginScreen extends StatefulWidget {
  final AuthCubit cubit;
  const LoginScreen({super.key, required this.cubit});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = widget.cubit;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        authCubit.goToGetStated();
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
                    key: state.loginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        Header(
                          title: "",
                          onBackTap: () {
                            authCubit.goToGetStated();
                          },
                        ),
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
                          'Your email address',
                          style: Styles.boldStyle(
                              fontSize: 14,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela),
                        ),
                        10.verticalSpace,
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          hintText: 'dlterragio@gmail.com',
                          onChanged: (val) {
                            state.user.email = val;
                          },
                        ),
                        15.verticalSpace,
                        Text(
                          'Choose a password',
                          style: Styles.boldStyle(
                              fontSize: 14,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela),
                        ),
                        10.verticalSpace,
                        InputField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            state.user.password = val;
                          },
                          passwordField: true,
                          hintText: 'min. 8 characters',
                        ),
                        20.verticalSpace,
                        ElevatedButton(
                          onPressed: () {
                            loader(() => authCubit.login());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.onPrimary,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Continue',
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
                              text: "  Don't have an account? ",
                              style: Styles.mediumStyle(
                                fontSize: 12,
                                color: context.colorScheme.secondary,
                                family: FontFamily.varela,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      authCubit.goToRegister();
                                    },
                                  text: "Create one",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: context.colorScheme.onPrimary,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              ]),
                        ),
                        15.verticalSpace,
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        15.verticalSpace,
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            AppImages.google,
                            height: 20,
                          ),
                          label: Text(
                            'Sign up with Google',
                            style: Styles.boldStyle(
                              fontSize: 14,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        15.verticalSpace,
                        // OutlinedButton.icon(
                        //   onPressed: () {},
                        //   icon: Image.asset(
                        //     AppImages.apple,
                        //     height: 25,
                        //   ),
                        //   label: Padding(
                        //     padding: const EdgeInsets.only(right: 8),
                        //     child: Text(
                        //       'Sign up with Apple',
                        //       style: Styles.boldStyle(
                        //         fontSize: 14,
                        //         color: context.colorScheme.onPrimary,
                        //         family: FontFamily.varela,
                        //       ),
                        //     ),
                        //   ),
                        //   style: OutlinedButton.styleFrom(
                        //     minimumSize: const Size(double.infinity, 48),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
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
