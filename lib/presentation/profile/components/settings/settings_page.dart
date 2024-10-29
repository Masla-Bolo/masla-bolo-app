import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';
import 'theme_switch.dart';
import '../../../../helpers/extensions.dart';

import '../../../../di/service_locator.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/styles/app_colors.dart';
import '../../../../helpers/styles/styles.dart';
import '../../../../helpers/widgets/header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static final cubit = getIt<SettingsCubit>();

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
                          fontSize: 20,
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
                            return GestureDetector(
                              onTap: () {
                                cubit.navigateToPage(setting.routeName);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.secondary
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      leading: CircleAvatar(
                                        radius: 24.w,
                                        backgroundColor: context
                                            .colorScheme.secondary
                                            .withOpacity(0.1),
                                        child: Icon(
                                          setting.icon,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                                      title: Text(
                                        setting.title,
                                        style: Styles.boldStyle(
                                          family: FontFamily.varela,
                                          fontSize: 16,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: context.colorScheme.onPrimary,
                                      )),
                                ),
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
                                child: Icon(
                                  Icons.power_settings_new_outlined,
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                              trailing: Text(
                                "Log Out",
                                style: Styles.boldStyle(
                                  family: FontFamily.varela,
                                  fontSize: 20,
                                  color: context.colorScheme.onPrimary,
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
