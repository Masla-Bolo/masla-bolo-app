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
  @override
  Widget build(BuildContext context) {
    final loginCubit = widget.cubit;
    loginCubit.navigation.context = context;
    return Scaffold(
      backgroundColor: AppColor.black5,
      body: BlocBuilder<AuthCubit, AuthState>(
          bloc: loginCubit,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputField(
                  onChanged: (val) {
                    state.email = val;
                  },
                  hintText: 'Email',
                ),
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
                    color: AppColor.white,
                    width: 170,
                    padding: const EdgeInsets.all(10),
                    child: state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: Text(
                            'GET IN!',
                            style: Styles.boldStyle(
                                fontSize: 20, color: AppColor.black3),
                          )),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
