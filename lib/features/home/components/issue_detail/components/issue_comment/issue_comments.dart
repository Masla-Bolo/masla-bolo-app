import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/components/issue_comment/comment_shimmer.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_state.dart';

import 'comment.dart';

class IssueComments extends StatelessWidget {
  const IssueComments({
    super.key,
    required this.comments,
    required this.cubit,
  });
  final List<CommentsEntity> comments;
  final IssueDetailCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return state.commentLoading
              ? const CommentShimmer()
              : ListView.builder(
                  itemCount: comments.length,
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Comment(comment: comment, cubit: cubit);
                  });
        });
  }
}
