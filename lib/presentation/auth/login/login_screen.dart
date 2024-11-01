import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di/service_locator.dart';
import '../../../domain/stores/user_store.dart';
import '../../../helpers/extensions.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/input_field.dart';
import '../auth_cubit.dart';
import '../auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authCubit = getIt<AuthCubit>();
  late String role;
  @override
  void initState() {
    super.initState();
    role = getIt<UserStore>().appUser.role ?? "user";
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
                        GestureDetector(
                          onTap: () {
                            authCubit.goToGetStated();
                          },
                          child: Icon(Icons.arrow_back_ios_new,
                              size: 20, color: context.colorScheme.onPrimary),
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
                          'Enter a password',
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
                        if (role == "user") ...[
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
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
                            onPressed: () {
                              loader(() => authCubit.googleSignIn());
                            },
                            icon: Image.asset(
                              AppImages.google,
                              height: 20,
                            ),
                            label: Text(
                              'Sign in with Google',
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
                        ],
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
