import 'package:flutter/material.dart';
import '../../domain/entities/issue_entity.dart';
import '../home/components/issue/issue_helper.dart';

class CreateIssueState {
  final GlobalKey<FormState> key;
  final IssueEntity issue;
  final List<IssueHelper> categories;
  final bool isLoading;
  CreateIssueState({
    required this.key,
    this.isLoading = false,
    required this.issue,
    required this.categories,
  });

  copyWith({
    GlobalKey<FormState>? key,
    IssueEntity? issue,
    bool? commentLoading,
    List<IssueHelper>? categories,
    bool? isLoading,
  }) =>
      CreateIssueState(
        isLoading: isLoading ?? this.isLoading,
        key: key ?? this.key,
        issue: issue ?? this.issue,
        categories: categories ?? this.categories,
      );

  factory CreateIssueState.empty() => CreateIssueState(
        key: GlobalKey<FormState>(),
        issue: IssueEntity.empty(),
        categories: IssueHelper.cloneInitialCategories(),
      );
}
