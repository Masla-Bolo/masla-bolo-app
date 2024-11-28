import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/di/service_locator.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_issues.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_state.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_verification.dart';

class OfficialProfile extends StatefulWidget {
  const OfficialProfile({super.key});

  @override
  State<OfficialProfile> createState() => _OfficialProfileState();
}

class _OfficialProfileState extends State<OfficialProfile> {
  final cubit = getIt<OfficialProfileCubit>();

  @override
  void initState() {
    super.initState();
    if (!cubit.state.isAllIssuesLoaded) cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficialProfileCubit, OfficialProfileState>(
        bloc: cubit,
        builder: (context, state) {
          final officialVerified = state.user.verified ?? false;
          return officialVerified
              ? const OfficialIssues()
              : const OfficialVerification();
        });
  }
}
