import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../../domain/entities/comments_entity.dart';
import '../../../../../domain/entities/issue_entity.dart';

class IssueDetailState {
  List<CommentsEntity> comments;
  CommentsEntity? replyTo;
  bool commentLoading;
  IssueEntity currentIssue;
  TextEditingController commentController;
  WebSocketChannel? channel;
  IssueDetailState({
    required this.currentIssue,
    required this.comments,
    required this.commentController,
    required this.channel,
    this.replyTo,
    this.commentLoading = false,
  });

  final focusNode = FocusNode();
  final key = GlobalKey<FormState>();

  copyWith({
    List<CommentsEntity>? comments,
    bool? commentLoading,
    CommentsEntity? replyTo,
    WebSocketChannel? channel,
    IssueEntity? currentIssue,
    TextEditingController? commentController,
  }) =>
      IssueDetailState(
        currentIssue: currentIssue ?? this.currentIssue,
        channel: channel ?? this.channel,
        replyTo: replyTo ?? replyTo,
        commentController: commentController ?? this.commentController,
        comments: comments ?? this.comments,
        commentLoading: commentLoading ?? this.commentLoading,
      );

  factory IssueDetailState.empty() => IssueDetailState(
        currentIssue: IssueEntity.empty(),
        channel: null,
        commentController: TextEditingController(),
        replyTo: null,
        comments: List<CommentsEntity>.empty(growable: true),
      );
}
