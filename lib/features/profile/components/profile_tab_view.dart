import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/features/profile/profile_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/widgets/shimmer_effect.dart';
import 'package:masla_bolo_app/service/app_service.dart';

import '../../../helpers/styles/styles.dart';

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
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 0.8.sw,
                        height: 0.1.sh,
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
                        return Padding(
                          key: Key("$index"),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: context.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 2.h),
                              title: Text(
                                issue.title,
                                style: Styles.boldStyle(
                                  family: FontFamily.varela,
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              subtitle: Text(
                                issue.description,
                                style: Styles.boldStyle(
                                  family: FontFamily.varela,
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
        });
  }
}
