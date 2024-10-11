import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/features/profile/profile_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/service/app_service.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/styles/styles.dart';
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
                        return GestureDetector(
                          onTap: () {
                            cubit.goToIssueDetail(issue);
                          },
                          child: Padding(
                            key: Key("$index"),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: context.colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        child: Icon(
                                          Icons.person,
                                          size: 12,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              issue.user.username!,
                                              style: Styles.boldStyle(
                                                family: FontFamily.varela,
                                                fontSize: 14,
                                                color:
                                                    context.colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              issue.status.name.capitalized(),
                                              style: Styles.boldStyle(
                                                fontSize: 12,
                                                family: FontFamily.dmSans,
                                                color: IssueHelper
                                                    .getIssueStatusColor(
                                                        issue.status),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        formatDate(issue.createdAt),
                                        style: Styles.mediumStyle(
                                          family: FontFamily.dmSans,
                                          fontSize: 12,
                                          color: context.colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    issue.title,
                                    style: Styles.boldStyle(
                                      family: FontFamily.varela,
                                      fontSize: 16,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    issue.description,
                                    style: Styles.mediumStyle(
                                      family: FontFamily.dmSans,
                                      fontSize: 12,
                                      color: context.colorScheme.primary,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
        });
  }
}
