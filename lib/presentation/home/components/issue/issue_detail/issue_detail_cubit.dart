import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/model/comments_json.dart';
import 'package:masla_bolo_app/helpers/strings.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../domain/entities/comments_entity.dart';
import '../../../../../domain/repositories/comment_repository.dart';
import '../../../../../domain/stores/user_store.dart';
import '../issue_cubit.dart';
import 'issue_detail_initial_params.dart';
import '../../../../../service/image_service.dart';
import '../../../../../service/music_service.dart';

import '../../../../../data/local_storage/local_storage_repository.dart';
import '../../../../../di/service_locator.dart';
import '../../../../../domain/repositories/issue_repository.dart';
import 'issue_detail_navigator.dart';
import 'issue_detail_state.dart';

class IssueDetailCubit extends Cubit<IssueDetailState> {
  final IssueDetailInitialParams params;
  final IssueDetailNavigator navigator;
  final ImageService imageHelper;
  final CommentRepository commentRepository;
  final IssueRepository issueRepository;
  final LocalStorageRepository localStorageRepository;
  final MusicService musicService;

  IssueDetailCubit(
    this.params,
    this.localStorageRepository,
    this.issueRepository,
    this.navigator,
    this.imageHelper,
    this.commentRepository,
    this.musicService,
  ) : super(IssueDetailState.empty());

  void goBack() {
    navigator.pop();
  }

  void fetchIssueComments() {
    emit(state.copyWith(
      commentLoading: true,
      currentIssue: params.issue,
    ));
    initWebSocket();
    commentRepository.getComments(params: {
      'issueId': params.issue.id,
    }).then(
      (response) => response.fold((error) {}, (comments) {
        if (comments.isNotEmpty) {
          emit(state.copyWith(
            comments: comments,
          ));
        }
        emit(state.copyWith(commentLoading: false));
      }),
    );
  }

  Future<void> addComment() async {
    final user = await getIt<UserStore>().getUser();
    final comment = CommentsEntity(
      content: state.commentController.text,
      issueId: params.issue.id,
      user: user,
    );
    if (state.replyTo != null) {
      // meaning this comment is replying to someOne
      // if the replied comment"s parent is null then the current comment"s parent
      // will the one which the comment is replying to or else the parent of this
      // comment will be the parent of the comment that this current comment is replying to
      comment.replyTo = state.replyTo!.user!.id;
      if (state.replyTo?.parent == null) {
        comment.parent = state.replyTo!.id;
      } else {
        comment.parent = state.replyTo!.parent;
      }
      final parent = state.replyTo?.parent ?? state.replyTo!.id;
      final parentComment = state.comments.firstWhereOrNull((comment) {
        return comment.id == parent;
      });
      parentComment?.showReplies = true;
      parentComment?.replies.insert(0, comment);
    } else {
      state.comments.insert(0, comment);
    }
    emit(state.copyWith(comments: state.comments));
    onChanged("");
    commentRepository.createComment(comment);
  }

  void showHideReply(CommentsEntity newComment) {
    state.comments.firstWhereOrNull(
      (comment) {
        return comment.id == newComment.id;
      },
    )!.showReplies = !newComment.showReplies;
    emit(state.copyWith(
      comments: state.comments,
    ));
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
        if (comment.isLiked) {
          musicService.play(musicService.likeUnlikeMusic);
        } else {
          musicService.play(musicService.likeUnlikeMusic);
        }
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

  void initWebSocket() async {
    state.channel = WebSocketChannel.connect(
      Uri.parse(socketUrl(params.issue.id)),
    );
    if (state.channel != null) {
      try {
        log("MAKING SOCKET CONNECTION....");
        await state.channel!.ready;
        log("SOCKET CONNECTED FOR: ${params.issue.id}");
        state.channel!.stream.listen(
          (data) => addSocketComment(data),
          onError: (e) {
            log("SOCKET ERROR: $e");
          },
        );
      } on SocketException catch (e) {
        log("Socket Error: ${e.toString()}");
      } on WebSocketChannelException catch (e) {
        log("Websocket Error: ${e.toString()}");
      }
    }
  }

  void addSocketComment(dynamic data) {
    final commentData = jsonDecode(data)["comment"];
    final streamComment = CommentsJson.fromJson(commentData).toDomain();
    if (streamComment.parent != null) {
      final parentComment = state.comments.firstWhereOrNull((comment) {
        return comment.id == streamComment.parent;
      });
      if (parentComment != null) {
        parentComment.showReplies = true;
        parentComment.replies.insert(0, streamComment);
      } else {
        state.comments.insert(0, streamComment);
      }
    } else {
      state.comments.insert(0, streamComment);
    }
    emit(state.copyWith(comments: state.comments));
  }

  @override
  Future<void> close() {
    state.channel!.sink.close();
    return super.close();
  }
}
