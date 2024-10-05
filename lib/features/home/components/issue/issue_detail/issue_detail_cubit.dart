import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';
import 'package:masla_bolo_app/domain/repositories/comment_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';

import '../../../../../domain/repositories/issue_repository.dart';
import '../../../../../service/app_service.dart';
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

  void fetchIssueComments() {
    emit(state.copyWith(
      commentLoading: true,
      currentIssue: params.issue,
    ));
    commentRepository.getComments(params: {
      'issueId': params.issue.id,
    }).then(
      (comments) => {
        if (comments.isNotEmpty)
          {
            emit(state.copyWith(
              comments: comments,
            )),
          },
        emit(state.copyWith(commentLoading: false)),
      },
    );
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }

  Future<void> addComment() async {
    final user = await getIt<UserStore>().getUser();
    final comment = CommentsEntity(
      content: state.commentController.text,
      issueId: params.issue.id,
      user: user,
    );
    if (state.replyTo != null) {
      comment.replyTo = state.replyTo?.user;
      if (state.replyTo?.parent == null) {
        comment.parent = state.replyTo;
      } else {
        comment.parent = state.replyTo?.parent;
      }
      final parent = state.replyTo?.parent ?? state.replyTo;
      final parentComment = state.comments.firstWhereOrNull((comment) {
        return comment.id == parent?.id;
      });
      parentComment?.replies.insert(0, comment);
    } else {
      state.comments.insert(0, comment);
    }
    emit(state.copyWith(comments: state.comments));
    onChanged("");
    commentRepository.createComment(comment);
  }

  void makeReply(CommentsEntity replyTo) {
    state.commentController.removeListener(textControllerListener);
    emit(
      state.copyWith(
        commentController: state.commentController,
        replyTo: replyTo,
      ),
    );
    state.commentController.text = "${replyTo.user?.username} ";
    state.focusNode.requestFocus();
    state.commentController.addListener(textControllerListener);
  }

  textControllerListener() {
    if (state.commentController.text.isEmpty) {
      emit(
        state.copyWith(
          replyTo: null,
        ),
      );
      state.commentController.removeListener(textControllerListener);
    }
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
    getIt<IssueCubit>().likeUnlikeIssue(state.currentIssue);
    emit(state.copyWith(currentIssue: state.currentIssue));
  }

  void onChanged(String value) {
    state.commentController.text = value;
  }
}
