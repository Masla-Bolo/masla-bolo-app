import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_post/issue_post.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_post/issue_post_shimmer.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        final threshold = scrollController.position.maxScrollExtent * 0.2;
        if (scrollController.position.pixels >= threshold) {
          widget.cubit.scrollAndCall();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueCubit, IssueState>(
        bloc: widget.cubit,
        builder: (context, state) {
          return !state.isLoaded
              ? const IssuePostShimmer()
              : Expanded(
                  child: RefreshIndicator(
                    color: context.colorScheme.onPrimary,
                    backgroundColor: context.colorScheme.primary,
                    onRefresh: () async {
                      await widget.cubit.refreshIssues();
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: state.issuesPagination.results.length,
                      separatorBuilder: (contex, index) {
                        return Divider(
                          color: context.colorScheme.secondary.withOpacity(0.1),
                          thickness: 7,
                          height: 7,
                        );
                      },
                      itemBuilder: (context, index) {
                        final issue = state.issuesPagination.results[index];
                        return IssuePost(
                          index: index,
                          cubit: widget.cubit,
                          issue: issue,
                        );
                      },
                    ),
                  ),
                );
        });
  }
}
