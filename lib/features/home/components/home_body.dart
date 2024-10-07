import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_post/issue_post.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_post/issue_post_shimmer.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/widgets/scroll_shader_mask.dart';

import '../../../helpers/styles/app_colors.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.cubit});
  final IssueCubit cubit;

  static final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueCubit, IssueState>(
        bloc: cubit,
        builder: (context, state) {
          return !state.isLoaded
              ? const IssuePostShimmer()
              : Expanded(
                  child: RefreshIndicator(
                    color: AppColor.black1,
                    backgroundColor: AppColor.white,
                    onRefresh: () async {
                      await cubit.refreshIssues();
                    },
                    child: ScrollShaderMask(
                      scrollController: scrollController,
                      callback: () {
                        cubit.scrollAndCall();
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.issuesPagination.results.length,
                        separatorBuilder: (contex, index) {
                          return Divider(
                            color: Colors.grey.shade300,
                            thickness: 7,
                            height: 7,
                          );
                        },
                        itemBuilder: (context, index) {
                          final issue = state.issuesPagination.results[index];
                          return IssuePost(
                            index: index,
                            cubit: cubit,
                            issue: issue,
                          );
                        },
                      ),
                    ),
                  ),
                );
        });
  }
}
