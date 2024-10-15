import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/home/components/home_filter_drawer.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/widgets/indicator.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';

import '../../helpers/styles/styles.dart';
import '../../service/app_service.dart';
import 'components/issue/issue_post/issue_post.dart';
import 'components/issue/issue_post/issue_post_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = getIt<IssueCubit>();
  final controller = TextEditingController();
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    if (!homeCubit.state.isLoaded) {
      homeCubit.getIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const HomeFilterDrawer(),
      onEndDrawerChanged: (result) {
        getIt<BottomBarCubit>().toggleVisibility();
      },
      body: SafeArea(
        child: BlocBuilder<IssueCubit, IssueState>(
            bloc: homeCubit,
            builder: (context, state) {
              return RefreshIndicator(
                color: context.colorScheme.onPrimary,
                backgroundColor: context.colorScheme.primary,
                onRefresh: () async {
                  homeCubit.refreshIssues();
                },
                child: CustomScrollView(
                  restorationId: "home",
                  controller: state.scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 0.07.sh,
                      floating: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.verticalSpace,
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
                        ],
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () => Scaffold.of(context).openEndDrawer(),
                          child: Image.asset(
                            AppImages.filter,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 35,
                          width: 1.sw,
                          child: InputField(
                            borderRadius: 20,
                            suffixIcon: Icon(
                              Icons.search,
                              color: context.colorScheme.onPrimary,
                            ),
                            onChanged: (val) {
                              homeCubit.onChanged(val);
                            },
                            hintText: "Search Issues",
                          ),
                        ),
                      ),
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
              return const IssuePostShimmer();
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
                    index: index,
                    cubit: homeCubit,
                    description: description,
                    issue: issue,
                    descriptionThreshold: state.descriptionThreshold,
                    calledSeeMore: () {
                      homeCubit.toggleSeeMore(issue);
                    },
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
