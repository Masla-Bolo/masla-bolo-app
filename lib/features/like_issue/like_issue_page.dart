import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/like_issue/like_issue_cubit.dart';
import 'package:masla_bolo_app/features/like_issue/like_issue_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/widgets/issue_container.dart';
import 'package:masla_bolo_app/helpers/widgets/scroll_shader_mask.dart';

import '../../helpers/styles/styles.dart';
import '../../helpers/widgets/indicator.dart';
import '../../helpers/widgets/shimmer_effect.dart';

class LikeIssuePage extends StatefulWidget {
  final LikeIssueCubit cubit;

  const LikeIssuePage({
    super.key,
    required this.cubit,
  });

  @override
  State<LikeIssuePage> createState() => _LikeIssuePageState();
}

class _LikeIssuePageState extends State<LikeIssuePage> {
  late LikeIssueCubit cubit;
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
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
                      "YOUR FAVOURITE ISSUES",
                      maxLines: 1,
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Builder(builder: (context) {
                    return (!state.isLoaded)
                        ? Expanded(
                            child: ListView.builder(
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
                                }),
                          )
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
                            : Expanded(
                                child: RefreshIndicator(
                                  color: context.colorScheme.onPrimary,
                                  onRefresh: () async {
                                    await cubit.refreshIssues();
                                  },
                                  child: ScrollShaderMask(
                                    scrollController: scrollController,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                  ),
                                ),
                              );
                  }),
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