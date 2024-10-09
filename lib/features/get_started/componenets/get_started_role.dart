import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    15.verticalSpace,
                    GetStartedHeader(
                      hideNext: true,
                      onBackTap: () {
                        cubit.goToPreviousPage();
                      },
                    ),
                    30.verticalSpace,
                    Center(
                      child: Text(
                        "Choose your role below",
                        textAlign: TextAlign.center,
                        style: Styles.boldStyle(
                          fontSize: 40,
                          family: FontFamily.dmSans,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    50.verticalSpace,
                    RoleCard(
                      title: "Citizen",
                      tagLine: "Your Voice, Your Power",
                      icon: Icons.person,
                      isSelected: state.selectedRole == "user",
                      onTap: () => cubit.selectRole("user"),
                    ),
                    20.verticalSpace,
                    Text(
                      "or",
                      style: Styles.lightStyle(
                        fontSize: 20,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                    20.verticalSpace,
                    RoleCard(
                      title: "Official",
                      left: false,
                      tagLine: "Serving the People, Upholding Justice",
                      icon: Icons.security,
                      isSelected: state.selectedRole == "official",
                      onTap: () => cubit.selectRole("official"),
                    ),
                    80.verticalSpace,
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
                                color: context.colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: Styles.semiBoldStyle(
                                      fontSize: 20.sp,
                                      color: context.colorScheme.primary,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Icon(
                                    Icons.arrow_forward,
                                    color: context.colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
