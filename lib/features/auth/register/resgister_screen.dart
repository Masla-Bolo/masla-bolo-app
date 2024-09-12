import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';

import '../../../helpers/widgets/indicator.dart';
import '../auth_cubit.dart';
import '../auth_state.dart';

class ResgisterScreen extends StatefulWidget {
  final AuthCubit cubit;
  const ResgisterScreen({super.key, required this.cubit});

  @override
  State<ResgisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResgisterScreen> {
  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = widget.cubit;
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
                      'Your user name',
                      style: Styles.boldStyle(
                          fontSize: 14, color: AppColor.black1),
                    ),
                    10.verticalSpace,
                    InputField(
                      keyboardType: TextInputType.name,
                      onChanged: (val) {},
                      hintText: 'abcxyz456',
                    ),
                    15.verticalSpace,
                    Text(
                      'Your email address',
                      style: Styles.boldStyle(
                          fontSize: 14, color: AppColor.black1),
                    ),
                    10.verticalSpace,
                    InputField(
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.visiblePassword,
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
                          : const Text('Register'),
                    ),
                    10.verticalSpace,
                    RichText(
                      text: TextSpan(
                          text: "  Already have an account? ",
                          style: Styles.mediumStyle(
                              fontSize: 12, color: AppColor.grey),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  authCubit.pop();
                                },
                              text: "Login",
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColor.black1,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ]),
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
