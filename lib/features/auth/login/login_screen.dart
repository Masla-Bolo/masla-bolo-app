import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/indicator.dart';
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
    authCubit.navigation.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.verticalSpace,
                    Center(
                      child: Text('MASLA BOLO!',
                          style: Styles.boldStyle(
                              fontSize: 30, color: AppColor.black1)),
                    ),
                    10.verticalSpace,
                    Center(
                      child: Text(
                        'Report local issues & drive real change!',
                        style: Styles.mediumStyle(
                            fontSize: 16, color: AppColor.grey),
                      ),
                    ),
                    80.verticalSpace,
                    Text(
                      'Your email address',
                      style: Styles.boldStyle(
                          fontSize: 14, color: AppColor.black1),
                    ),
                    10.verticalSpace,
                    InputField(
                      hintText: 'dlterragio@gmail.com',
                      onChanged: (val) {},
                    ),
                    15.verticalSpace,
                    Text(
                      'Choose a password',
                      style: Styles.boldStyle(
                          fontSize: 14, color: AppColor.black1),
                    ),
                    10.verticalSpace,
                    InputField(
                      onChanged: (val) {},
                      passwordField: true,
                      hintText: 'min. 8 characters',
                    ),
                    20.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        authCubit.login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state.isLoading
                          ? const Indicator()
                          : const Text('Continue'),
                    ),
                    10.verticalSpace,
                    RichText(
                      text: TextSpan(
                          text: "  Don't have an account? ",
                          style: Styles.mediumStyle(
                              fontSize: 12, color: AppColor.grey),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  authCubit.goToRegister();
                                },
                              text: "Create one",
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColor.black1,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ]),
                    ),
                    15.verticalSpace,
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('or'),
                        ),
                        Expanded(child: Divider()),
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
                            fontSize: 14, color: AppColor.black1),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        AppImages.apple,
                        height: 25,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Sign up with Apple',
                          style: Styles.boldStyle(
                              fontSize: 14, color: AppColor.black1),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
