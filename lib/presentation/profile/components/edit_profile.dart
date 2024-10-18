import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/presentation/profile/profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/profile_state.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/header.dart';
import '../../../helpers/widgets/input_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  static final profileCubit = getIt<ProfileCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: profileCubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Header(
                      fontSize: 20,
                      title: "Update Profile",
                      onBackTap: () {
                        profileCubit.pop();
                      },
                    ),
                    30.verticalSpace,
                    Text(
                      'Change your username',
                      style: Styles.boldStyle(
                          fontSize: 14,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela),
                    ),
                    10.verticalSpace,
                    InputField(
                      onChanged: (val) {
                        state.user.username = val;
                      },
                      hintText: state.user.username,
                    ),
                    20.verticalSpace,
                    Text(
                      'Change your email',
                      style: Styles.boldStyle(
                          fontSize: 14,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela),
                    ),
                    10.verticalSpace,
                    InputField(
                      onChanged: (val) {
                        state.user.email = val;
                      },
                      hintText: state.user.email,
                    ),
                    20.verticalSpace,
                    Text(
                      'Change your password',
                      style: Styles.boldStyle(
                          fontSize: 14,
                          color: context.colorScheme.onPrimary,
                          family: FontFamily.varela),
                    ),
                    10.verticalSpace,
                    InputField(
                      onChanged: (val) {
                        state.user.password = val;
                      },
                      passwordField: true,
                      hintText: 'min. 8 characters',
                    ),
                    SizedBox(height: 0.3.sh),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loader(() => profileCubit.updateProfile());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.onPrimary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Update',
                          style: Styles.mediumStyle(
                            fontSize: 15,
                            color: context.colorScheme.primary,
                            family: FontFamily.varela,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            )),
          );
        });
  }
}
