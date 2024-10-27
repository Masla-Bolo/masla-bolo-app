import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../domain/entities/comments_entity.dart';
import 'comment_shimmer.dart';
import '../../issue_detail_cubit.dart';
import '../../issue_detail_state.dart';
import '../../../../../../../helpers/extensions.dart';
import '../../../../../../../helpers/styles/styles.dart';

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
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: state.comments.isNotEmpty
                    ? AnimatedList(
                        initialItemCount: comments.length,
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index, animation) {
                          final comment = comments[index];
                          return SlideTransition(
                            position: animation.drive(
                              Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeInOut)),
                            ),
                            child: Comment(comment: comment, cubit: cubit),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "No comments to show...",
                            style: Styles.boldStyle(
                              fontSize: 17,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela,
                            ),
                          ),
                        ),
                      ),
              );
      },
    );
  }
}
