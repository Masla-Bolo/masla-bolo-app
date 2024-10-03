import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

class IssueDetailState {
  List<CommentsEntity> comments;
  final bool commentLoading;
  final focusNode = FocusNode();
  final TextEditingController commentController;
  IssueDetailState({
    required this.comments,
    required this.commentController,
    this.commentLoading = false,
  });

  final key = GlobalKey<FormState>();

  copyWith({
    List<CommentsEntity>? comments,
    bool? commentLoading,
    TextEditingController? commentController,
  }) =>
      IssueDetailState(
        commentController: commentController ?? this.commentController,
        comments: comments ?? this.comments,
        commentLoading: commentLoading ?? this.commentLoading,
      );

  factory IssueDetailState.empty() => IssueDetailState(
        commentController: TextEditingController(),
        comments: List<CommentsEntity>.empty(growable: true),
      );
}
