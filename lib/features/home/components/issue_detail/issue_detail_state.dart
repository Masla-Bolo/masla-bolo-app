import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

class IssueDetailState {
  List<CommentsEntity> comments;
  final bool commentLoading;
  final focusNode = FocusNode();
  IssueDetailState({
    required this.comments,
    this.commentLoading = false,
  });

  final key = GlobalKey<FormState>();

  copyWith({List<CommentsEntity>? comments, bool? commentLoading}) =>
      IssueDetailState(
        comments: comments ?? this.comments,
        commentLoading: commentLoading ?? this.commentLoading,
      );

  factory IssueDetailState.empty() => IssueDetailState(
        comments: List<CommentsEntity>.empty(),
      );
}
