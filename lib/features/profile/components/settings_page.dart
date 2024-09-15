import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/components/settings_cubit.dart';
import 'package:masla_bolo_app/features/profile/components/settings_state.dart';

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
            body: SafeArea(
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
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'SETTINGS SCREEN',
                    style: Styles.boldStyle(
                      fontSize: 20,
                      color: AppColor.black1,
                      family: FontFamily.dmSans,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }
}
