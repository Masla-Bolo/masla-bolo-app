import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';

import 'issue_detail_navigator.dart';
import 'issue_detail_state.dart';

class IssueDetailCubit extends Cubit<IssueDetailState> {
  final IssueDetailInitialParams params;
  final IssueDetailNavigator navigator;
  final ImageHelper imageHelper;
  final CommentRepository commentRepository;
  IssueDetailCubit(
    this.params,
    this.navigator,
    this.imageHelper,
    this.commentRepository,
  ) : super(IssueDetailState.empty());
  void goBack() {
    navigator.pop();
  }

  void fetchIssueComments(int id) {
    emit(state.copyWith(commentLoading: true));
    commentRepository.getComments(params: {
      'issue_id': id,
    }).then(
      (comments) => {
        emit(state.copyWith(
          comments: comments,
        )),
        emit(state.copyWith(commentLoading: false))
      },
    );
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }

  void addComment(String val, {int? replyTo}) {
    final comment = CommentsEntity(
      content: val,
      issueId: params.issue.id,
    );
    if (replyTo != null) {
      comment.replyTo = replyTo;
    }
    commentRepository.createComment(comment).then((comment) => {
          state.comments.add(comment),
          emit(state.copyWith(comments: state.comments))
        });
  }
}
