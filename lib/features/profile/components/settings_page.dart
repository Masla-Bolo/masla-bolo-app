import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/components/settings_cubit.dart';
import 'package:masla_bolo_app/features/profile/components/settings_state.dart';
import 'package:masla_bolo_app/features/profile/components/theme_switch.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.cubit});
  final SettingsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Header(
                          title: "Settings",
                          onBackTap: () {
                            cubit.pop();
                          },
                          suffix: const ThemeSwitch(),
                        ),
                      ),
                      20.verticalSpace,
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.appSettings.length,
                          itemBuilder: (context, index) {
                            final setting = state.appSettings[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.lightGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    leading: CircleAvatar(
                                      radius: 24.w,
                                      backgroundColor:
                                          AppColor.lightGrey.withOpacity(0.1),
                                      child: Icon(
                                        setting.icon,
                                        color: AppColor.black1,
                                      ),
                                    ),
                                    title: Text(
                                      setting.title,
                                      style: Styles.boldStyle(
                                        family: FontFamily.varela,
                                        fontSize: 16,
                                        color: AppColor.black1,
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.black1,
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () async {
                            if (await showConfirmationDialog(
                                    'Are you sure you want to log Out?') &&
                                context.mounted) {
                              cubit.popAll();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: AppColor.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.h),
                              leading: CircleAvatar(
                                radius: 24.w,
                                backgroundColor: AppColor.red.withOpacity(0.1),
                                child: const Icon(
                                  Icons.power_settings_new_outlined,
                                  color: AppColor.black1,
                                ),
                              ),
                              trailing: Text(
                                "Log Out",
                                style: Styles.boldStyle(
                                  family: FontFamily.varela,
                                  fontSize: 16,
                                  color: AppColor.black1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isLoggingOut)
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 3,
                      sigmaY: 3,
                      tileMode: TileMode.repeated,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
