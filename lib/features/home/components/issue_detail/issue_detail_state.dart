import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/comments_entity.dart';

class IssueDetailState {
  List<CommentsEntity> comments;
  IssueDetailState({required this.comments});

  final key = GlobalKey<FormState>();

  copyWith({List<CommentsEntity>? comments}) =>
      IssueDetailState(comments: comments ?? this.comments);

  factory IssueDetailState.empty() => IssueDetailState(
        comments: List<CommentsEntity>.empty(),
      );
}
