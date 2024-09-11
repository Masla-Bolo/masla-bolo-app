import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../../main.dart';
import '../get_started_state.dart';
import 'role_card.dart';

class GetStartedRole extends StatefulWidget {
  const GetStartedRole({super.key});

  @override
  State<GetStartedRole> createState() => _GetStartedRoleState();
}

class _GetStartedRoleState extends State<GetStartedRole> {
  late GetStartedCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<GetStartedCubit>();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStartedCubit, GetStartedState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you a Citizen or Official?",
                  style: Styles.boldStyle(
                    fontSize: 32.sp,
                    color: AppColor.black1,
                  ),
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoleCard(
                      role: "Citizen",
                      icon: Icons.person,
                      isSelected: state.selectedRole == "User",
                      onTap: () => cubit.selectRole("User"),
                    ),
                    RoleCard(
                      role: "Official",
                      icon: Icons.security,
                      isSelected: state.selectedRole == "Official",
                      onTap: () => cubit.selectRole("Official"),
                    ),
                  ],
                ),
                50.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: state.selectedRole.isEmpty ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          if (state.selectedRole.isNotEmpty) {
                            cubit.goToLogin();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColor.black1,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: Styles.semiBoldStyle(
                                fontSize: 20.sp,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
