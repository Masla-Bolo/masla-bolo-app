import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/features/profile/profile_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/service/app_service.dart';

import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/issue_container.dart';
import '../../../helpers/widgets/shimmer_effect.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({super.key, required this.status});
  final String status;

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  final cubit = getIt<ProfileCubit>();
  @override
  void initState() {
    super.initState();
  }

  onScroll() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          final issues = state.issues[widget.status] ?? [];
          return (!state.isLoaded)
              ? ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: 0.2.sh,
                        width: 0.7.sw,
                        child: const ShimmerEffect(),
                      ),
                    );
                  })
              : (issues.isEmpty && state.isLoaded)
                  ? Center(
                      child: Text(
                        "No Issues found",
                        style: Styles.boldStyle(
                          family: FontFamily.varela,
                          fontSize: 16,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: issues.length,
                      itemBuilder: (context, index) {
                        final issue = issues[index];
                        return IssueContainer(
                          issue: issue,
                          onTap: () {
                            cubit.goToIssueDetail(issue);
                          },
                        );
                      },
                    );
        });
  }
}
