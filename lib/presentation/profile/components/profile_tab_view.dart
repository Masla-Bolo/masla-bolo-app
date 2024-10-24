import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../profile_cubit.dart';
import '../profile_state.dart';
import '../../../helpers/extensions.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/indicator.dart';
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
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        final threshold = scrollController.position.maxScrollExtent * 0.2;
        if (scrollController.position.pixels >= threshold) {
          cubit.scrollAndCall(widget.status);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          final result = state.allIssues[widget.status]!;
          final isLoaded = result.isLoaded;
          final isScrolled = result.isScrolled;
          final issues = result.issues.results;
          return RefreshIndicator(
            color: context.colorScheme.onPrimary,
            onRefresh: () async {
              if (isLoaded) {
                await cubit.refreshIssues(widget.status);
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              key: PageStorageKey(widget.status),
              restorationId: widget.status,
              child: (!isLoaded)
                  ? ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                  : (issues.isEmpty && isLoaded)
                      ? SizedBox(
                          height: 0.5.sh,
                          child: Center(
                            child: Text(
                              "No Issues found",
                              style: Styles.boldStyle(
                                family: FontFamily.varela,
                                fontSize: 16,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
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
                            ),
                            if (!isScrolled && isLoaded)
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Indicator(),
                              ),
                          ],
                        ),
            ),
          );
        });
  }
}
