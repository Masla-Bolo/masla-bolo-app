import 'package:flutter/material.dart';
import '../../../../../domain/entities/comments_entity.dart';
import '../../../../../domain/entities/issue_entity.dart';

class IssueDetailState {
  List<CommentsEntity> comments;
  CommentsEntity? replyTo;
  bool commentLoading;
  IssueEntity currentIssue;
  TextEditingController commentController;
  IssueDetailState({
    required this.currentIssue,
    required this.comments,
    required this.commentController,
    this.replyTo,
    this.commentLoading = false,
  });

  final focusNode = FocusNode();
  final key = GlobalKey<FormState>();

  copyWith({
    List<CommentsEntity>? comments,
    bool? commentLoading,
    CommentsEntity? replyTo,
    IssueEntity? currentIssue,
    TextEditingController? commentController,
  }) =>
      IssueDetailState(
        currentIssue: currentIssue ?? this.currentIssue,
        replyTo: replyTo ?? replyTo,
        commentController: commentController ?? this.commentController,
        comments: comments ?? this.comments,
        commentLoading: commentLoading ?? this.commentLoading,
      );

  factory IssueDetailState.empty() => IssueDetailState(
        currentIssue: IssueEntity.empty(),
        commentController: TextEditingController(),
        replyTo: null,
        comments: List<CommentsEntity>.empty(growable: true),
      );
}
