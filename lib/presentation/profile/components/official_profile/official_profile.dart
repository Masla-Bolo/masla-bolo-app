import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/di/service_locator.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_issues.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_verification.dart';
import 'package:masla_bolo_app/presentation/profile/profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/profile_state.dart';

class OfficialProfile extends StatelessWidget {
  const OfficialProfile({super.key});

  static final cubit = getIt<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          final officialVerified = state.user.verified;
          log("VERIFIED: $officialVerified");
          return officialVerified // TODO: Invert it later
              ? const OfficialIssues()
              : const OfficialVerification();
        });
  }
}
