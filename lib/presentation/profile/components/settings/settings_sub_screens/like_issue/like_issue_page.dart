import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/issue_container_shimmer.dart';
import 'like_issue_cubit.dart';
import 'like_issue_state.dart';
import '../../../../../../helpers/extensions.dart';
import '../../../../../../helpers/widgets/issue_container.dart';

import '../../../../../../di/service_locator.dart';
import '../../../../../../helpers/styles/styles.dart';
import '../../../../../../helpers/widgets/indicator.dart';

class LikeIssuePage extends StatefulWidget {
  const LikeIssuePage({
    super.key,
  });

  @override
  State<LikeIssuePage> createState() => _LikeIssuePageState();
}

class _LikeIssuePageState extends State<LikeIssuePage> {
  final cubit = getIt<LikeIssueCubit>();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (!cubit.state.isLoaded) {
      cubit.getLikedIssues();
    }
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        final threshold = scrollController.position.maxScrollExtent * 0.2;
        if (scrollController.position.pixels >= threshold) {
          cubit.scrollAndCall();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikeIssueCubit, LikeIssueState>(
        bloc: cubit,
        builder: (context, state) {
          final issues = state.issuesPagination.results;
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "YOUR RAISED ISSUES",
                      maxLines: 1,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: RefreshIndicator(
                      color: context.colorScheme.onPrimary,
                      onRefresh: () async {
                        if (state.isLoaded) {
                          await cubit.refreshIssues();
                        }
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: (!state.isLoaded)
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return const IssueContainerShimmer();
                                })
                            : (issues.isEmpty && state.isLoaded)
                                ? SizedBox(
                                    height: 0.5.sh,
                                    child: Center(
                                      child: Text(
                                        "No Raised Issues found",
                                        style: Styles.boldStyle(
                                          family: FontFamily.varela,
                                          fontSize: 16,
                                          color: context.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: issues.length,
                                    itemBuilder: (context, index) {
                                      final issue = issues[index];
                                      return IssueContainer(
                                        image: issue.user.image,
                                        issue: issue,
                                        onTap: () {
                                          cubit.goToIssueDetail(issue);
                                        },
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ),
                  if (!state.isScrolled && state.isLoaded)
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
