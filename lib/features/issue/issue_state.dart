import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';

class IssueState {
  final GlobalKey<FormState> key;
  final IssueEntity issue;
  final List<IssueHelper> categories;
  IssueState({
    required this.key,
    required this.issue,
    required this.categories,
  });

  copyWith({
    GlobalKey<FormState>? key,
    IssueEntity? issue,
    List<IssueHelper>? categories,
  }) =>
      IssueState(
        key: key ?? this.key,
        issue: issue ?? this.issue,
        categories: categories ?? this.categories,
      );

  factory IssueState.empty() => IssueState(
        key: GlobalKey<FormState>(),
        issue: IssueEntity.empty(),
        categories: IssueHelper.cloneCategories(),
      );
}
