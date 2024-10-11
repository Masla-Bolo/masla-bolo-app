import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/home/components/home_filter_drawer.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../helpers/styles/styles.dart';
import '../../service/app_service.dart';
import 'components/issue/issue_post/issue_post.dart';
import 'components/issue/issue_post/issue_post_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IssueCubit homeCubit;
  final scrollController = ScrollController();
  final controller = TextEditingController();
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    homeCubit = widget.cubit;
    focusNode = FocusNode();
    if (!homeCubit.state.isLoaded) {
      homeCubit.getIssues();
    }
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        final threshold = scrollController.position.maxScrollExtent * 0.2;
        if (scrollController.position.pixels >= threshold) {
          homeCubit.scrollAndCall();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeFilterDrawer(cubit: homeCubit),
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
                  await widget.cubit.refreshIssues();
                },
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 0.05.sh,
                      floating: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    SliverList(delegate: getDelegate(state)),
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
              return IssuePost(
                index: index,
                cubit: widget.cubit,
                issue: issue,
              );
            },
            childCount: state.issuesPagination.results.length,
          );
  }
}
