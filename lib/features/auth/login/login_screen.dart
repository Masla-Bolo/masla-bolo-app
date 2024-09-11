import 'package:masla_bolo_app/features/auth/auth_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../auth_state.dart';

class LoginScreen extends StatefulWidget {
  final AuthCubit cubit;
  const LoginScreen({super.key, required this.cubit});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit loginCubit;
  @override
  void initState() {
    super.initState();
    loginCubit = widget.cubit;
    loginCubit.navigation.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
          bloc: loginCubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputField(
                    onChanged: (val) {
                      state.email = val;
                    },
                    hintText: 'Email',
                  ),
                  const Gap(30),
                  InputField(
                    onChanged: (val) {
                      state.password = val;
                    },
                    hintText: 'Password',
                  ),
                  const Gap(30),
                  GestureDetector(
                    onTap: () => loginCubit.login(
                      state.email,
                      state.password,
                      context,
                    ),
                    child: Container(
                      width: 170,
                      decoration: BoxDecoration(
                        color: AppColor.black1,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Center(
                              child: Text(
                              'GET IN!',
                              style: Styles.boldStyle(
                                  fontSize: 20, color: AppColor.white),
                            )),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
