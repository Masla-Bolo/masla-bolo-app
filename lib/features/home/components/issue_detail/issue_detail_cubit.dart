import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import '../../../../domain/repositories/issue_repository.dart';
import 'issue_detail_navigator.dart';
import 'issue_detail_state.dart';

class IssueDetailCubit extends Cubit<IssueDetailState> {
  final IssueDetailInitialParams params;
  final IssueDetailNavigator navigator;
  final ImageHelper imageHelper;
  final CommentRepository commentRepository;
  final IssueRepository issueRepository;
  final LocalStorageRepository localStorageRepository;

  IssueDetailCubit(
    this.params,
    this.localStorageRepository,
    this.issueRepository,
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
      'issueId': id,
    }).then(
      (comments) => {
        if (comments.isNotEmpty)
          {
            emit(state.copyWith(
              comments: comments,
            )),
          },
        emit(state.copyWith(
          commentLoading: false,
        )),
      },
    );
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }

  Future<void> addComment({CommentsEntity? replyTo}) async {
    final user = await localStorageRepository.getUser(userKey).then(
          (response) => response.fold(
            (_) {},
            (user) => user,
          ),
        );
    final comment = CommentsEntity(
      content: state.commentController.text,
      issueId: params.issue.id,
      user: user,
    );
    onChanged("");
    if (replyTo != null) {
      comment.replyTo = replyTo.user;
      if (replyTo.parent == null) {
        comment.parent = replyTo;
      } else {
        comment.parent = replyTo.parent;
      }
      final parent = replyTo.parent ?? replyTo;
      state.comments
          .where((comment) => comment.id == parent.id)
          .map((parentComment) => {
                parentComment.replies.add(comment),
              });
    } else {
      state.comments.add(comment);
    }
    emit(state.copyWith(comments: state.comments));
    commentRepository.createComment(comment);
  }

  void makeReply(String username) {
    emit(
      state.copyWith(
        commentController: state.commentController,
      ),
    );
    state.commentController.text = "$username ";
    state.focusNode.requestFocus();
  }

  void likeUnlikeComment(int commentId) {
    var targetComment = state.comments.firstWhereOrNull(
      (comment) =>
          comment.id == commentId ||
          comment.replies.any((reply) => reply.id == commentId),
    );

    if (targetComment != null) {
      var comment = targetComment.id == commentId
          ? targetComment
          : targetComment.replies
              .firstWhereOrNull((reply) => reply.id == commentId);

      if (comment != null) {
        comment.isLiked = !comment.isLiked;
        emit(state.copyWith(comments: state.comments));
        commentRepository.likeUnlikeComment(commentId);
      }
    }
  }

  void likeUnlikeIssue() {
    params.issue.isLiked = !params.issue.isLiked;
    // issueRepository.likeUnlikeIssue(params.issue.id);
  }

  void onChanged(String value) {
    state.commentController.text = value;
  }
}
