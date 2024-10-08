import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/components/issue_comment/issue_comments.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../../../../helpers/styles/styles.dart';

class IssueDetailDiscussion extends StatelessWidget {
  const IssueDetailDiscussion({
    super.key,
    required this.focusNode,
    required this.cubit,
  });
  final IssueDetailCubit cubit;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: [
              10.verticalSpace,
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          cubit.likeUnlikeIssue();
                        },
                        icon: Icon(
                          state.currentIssue.isLiked
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          color: context.colorScheme.onPrimary,
                        ),
                        label: Text(
                          state.currentIssue.likesCount < 1
                              ? 'Like'
                              : state.currentIssue.likesCount == 1
                                  ? "1 Like"
                                  : "${state.currentIssue.likesCount} Likes",
                          style: Styles.boldStyle(
                            fontSize: 12,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: VerticalDivider(
                        color: context.colorScheme.secondary,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          focusNode.requestFocus();
                        },
                        icon: Icon(
                          Icons.comment,
                          color: context.colorScheme.onPrimary,
                        ),
                        label: Text(
                          state.currentIssue.commentsCount < 1
                              ? 'comment'
                              : state.currentIssue.commentsCount == 1
                                  ? "1 comment"
                                  : "${state.currentIssue.commentsCount} comments",
                          style: Styles.boldStyle(
                            fontSize: 14,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              IssueComments(
                comments: state.comments,
                cubit: cubit,
              ),
            ],
          );
        });
  }
}
