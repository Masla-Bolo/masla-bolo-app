import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/presentation/search_issue/search_issue_cubit.dart';
import 'package:masla_bolo_app/presentation/search_issue/search_issue_state.dart';

import '../../di/service_locator.dart';
import '../../helpers/styles/app_images.dart';
import '../../helpers/styles/styles.dart';
import '../../helpers/widgets/indicator.dart';
import '../../helpers/widgets/input_field.dart';
import '../home/components/issue/issue_post/issue_post.dart';
import '../home/components/issue/issue_post/issue_post_params.dart';
import '../home/components/issue/issue_post/issue_post_shimmer.dart';

class SearchIssuePage extends StatefulWidget {
  const SearchIssuePage({super.key});

  @override
  State<SearchIssuePage> createState() => _SearchIssuePageState();
}

class _SearchIssuePageState extends State<SearchIssuePage> {
  static final cubit = getIt<SearchIssueCubit>();
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    if (!cubit.state.isLoaded) {
      cubit.getIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SearchIssueCubit, SearchIssueState>(
            bloc: cubit,
            builder: (context, state) {
              return SingleChildScrollView(
                controller: state.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    10.verticalSpace,
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 2, 5),
                          child: SizedBox(
                            width: 0.85.sw,
                            height: 35,
                            child: InputField(
                              focusNode: focusNode,
                              onTap: null,
                              borderRadius: 10,
                              showCrossIcon: state.queryParams["search"] != null
                                  ? true
                                  : false,
                              onCrossTap: () {
                                cubit.clearSearchAndFetch();
                              },
                              onChanged: (val) {
                                cubit.onChanged(val);
                              },
                              preFilledValue: state.queryParams["search"],
                              hintText: "Search Issues",
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () {
                              cubit.goToSearchIssueFilter();
                            },
                            child: SvgPicture.asset(
                              AppImages.filter,
                              height: 35,
                              colorFilter: ColorFilter.mode(
                                context.colorScheme.onPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    !state.isLoaded
                        ? ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return const IssuePostShimmer();
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: context.colorScheme.secondary,
                                thickness: 1,
                              );
                            },
                            itemCount: 5,
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final issue =
                                  state.issuesPagination.results[index];
                              final end = issue.description.length >
                                          state.descriptionThreshold &&
                                      !issue.seeMore
                                  ? (issue.description.length / 2)
                                      .floor()
                                      .toInt()
                                  : issue.description.length;
                              final description =
                                  issue.description.substring(0, end);
                              return IssuePost(
                                params: IssuePostParams(
                                  index: index,
                                  likeUnlikeIssue: (issue) {
                                    cubit.likeUnlikeIssue(issue);
                                  },
                                  goToIssueDetail: (showComment, issue) {
                                    cubit.goToIssueDetail(
                                      showComment: showComment,
                                      issue: issue,
                                    );
                                  },
                                  description: description,
                                  updateIndex: (index) {
                                    cubit.updateIndex(index, issue);
                                  },
                                  currentImageIndex: issue.currentIndex,
                                  issue: issue,
                                  pageController: PageController(
                                      initialPage: issue.currentIndex),
                                  descriptionThreshold:
                                      state.descriptionThreshold,
                                  calledSeeMore: () {
                                    cubit.toggleSeeMore(issue);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: context.colorScheme.secondary,
                                thickness: 1,
                              );
                            },
                            itemCount: state.issuesPagination.results.length,
                          ),
                    if (!state.isScrolled && state.isLoaded)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Indicator(),
                      ),
                    if (state.isScrolled &&
                        state.isLoaded &&
                        state.issuesPagination.next == null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            state.issuesPagination.results.isNotEmpty
                                ? "thats it for now...\nNo more issues to show"
                                : "No issues to show for now try again later!!",
                            textAlign: TextAlign.center,
                            style: Styles.boldStyle(
                              fontSize: 14,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.dmSans,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
