import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../../service/app_service.dart';
import '../get_started_state.dart';
import 'get_started_header.dart';
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
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStartedCubit, GetStartedState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                15.verticalSpace,
                GetStartedHeader(
                  hideNext: true,
                  onBackTap: () {
                    cubit.goToPreviousPage();
                  },
                ),
                const Spacer(),
                Text(
                  "SELECT YOUR ROLE",
                  style: Styles.boldStyle(
                    fontSize: 32.sp,
                    family: FontFamily.dmSans,
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
                      isSelected: state.selectedRole == "user",
                      onTap: () => cubit.selectRole("user"),
                    ),
                    RoleCard(
                      role: "Official",
                      icon: Icons.security,
                      isSelected: state.selectedRole == "official",
                      onTap: () => cubit.selectRole("official"),
                    ),
                  ],
                ),
                50.verticalSpace,
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: GestureDetector(
                        onTap: () {
                          cubit.goToLogin();
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
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
