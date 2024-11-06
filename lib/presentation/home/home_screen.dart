import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bottom_bar/bottom_bar_cubit.dart';
import 'components/home_filter_drawer.dart';
import 'components/issue/issue_cubit.dart';
import 'components/issue/issue_post/issue_post_params.dart';
import 'components/issue/issue_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/extensions.dart';
import '../../helpers/styles/app_images.dart';
import '../../helpers/widgets/indicator.dart';
import '../../helpers/widgets/input_field.dart';

import '../../di/service_locator.dart';
import '../../helpers/styles/styles.dart';
import 'components/issue/issue_post/issue_post.dart';
import 'components/issue/issue_post/issue_post_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final issueCubit = getIt<IssueCubit>();
  final controller = TextEditingController();
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    if (!issueCubit.state.isLoaded) {
      issueCubit.getIssues().then((_) {
        issueCubit.initServices();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const HomeFilterDrawer(),
      onEndDrawerChanged: (result) {
        final bottomBarState = getIt<BottomBarCubit>();
        bottomBarState.toggleVisibility();
      },
      body: SafeArea(
        child: BlocBuilder<IssueCubit, IssueState>(
            bloc: issueCubit,
            builder: (context, state) {
              return RefreshIndicator(
                color: context.colorScheme.onPrimary,
                backgroundColor: context.colorScheme.primary,
                onRefresh: () async {
                  issueCubit.refreshIssues();
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: state.scrollController,
                  slivers: [
                    SliverAppBar(
                      toolbarHeight: 0.12.sh,
                      floating: true,
                      bottom: PreferredSize(
                        preferredSize: const Size(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 1.sw,
                            height: 35,
                            child: InputField(
                              focusNode: focusNode,
                              onTap: null,
                              borderRadius: 25,
                              showCrossIcon: state.queryParams["search"] != null
                                  ? true
                                  : false,
                              onCrossTap: () {
                                issueCubit.clearSearchAndFetch();
                              },
                              onChanged: (val) {
                                issueCubit.onChanged(val);
                              },
                              preFilledValue: state.queryParams["search"],
                              hintText: "Search Issues",
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          Text(
                            "MASLA BOLO",
                            style: Styles.boldStyle(
                              fontSize: 20,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.dmSans,
                            ),
                          ),
                          2.verticalSpace,
                          Text(
                            "Report local issues & drive real change.",
                            style: Styles.semiBoldStyle(
                              fontSize: 14,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela,
                            ),
                          ),
                          5.verticalSpace,
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 5),
                          child: GestureDetector(
                            onTap: () => Scaffold.of(context).openEndDrawer(),
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
                    SliverList(
                      delegate: getDelegate(state),
                    ),
                    if (!state.isScrolled && state.isLoaded)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Indicator(),
                        ),
                      ),
                    if (state.isScrolled &&
                        state.isLoaded &&
                        state.issuesPagination.next == null)
                      SliverToBoxAdapter(
                          child: Padding(
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
                      )),
                  ],
                ),
              );
            }),
      ),
    );
  }

  SliverChildBuilderDelegate getDelegate(IssueState state) {
    return !state.isLoaded
        ? SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  const IssuePostShimmer(),
                  if (index != 5)
                    Divider(
                      color: context.colorScheme.secondary,
                      thickness: 1,
                    ),
                ],
              );
            },
            childCount: 5,
          )
        : SliverChildBuilderDelegate(
            (context, index) {
              final issue = state.issuesPagination.results[index];
              final end =
                  issue.description.length > state.descriptionThreshold &&
                          !issue.seeMore
                      ? (issue.description.length / 2).floor().toInt()
                      : issue.description.length;
              final description = issue.description.substring(0, end);
              return Column(
                children: [
                  IssuePost(
                    params: IssuePostParams(
                      index: index,
                      cubit: issueCubit,
                      description: description,
                      updateIndex: (index) {
                        issueCubit.updateIndex(index, issue);
                      },
                      currentImageIndex: issue.currentIndex,
                      issue: issue,
                      pageController:
                          PageController(initialPage: issue.currentIndex),
                      descriptionThreshold: state.descriptionThreshold,
                      calledSeeMore: () {
                        issueCubit.toggleSeeMore(issue);
                      },
                    ),
                  ),
                  5.verticalSpace,
                  if (index != state.issuesPagination.results.length - 1)
                    Divider(
                      color: context.colorScheme.secondary,
                      thickness: 1,
                    ),
                ],
              );
            },
            childCount: state.issuesPagination.results.length,
          );
  }
}
