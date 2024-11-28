import 'package:flutter/material.dart';

import '../../../../../../domain/entities/issue_entity.dart';
import '../../../../../../domain/model/paginate.dart';

class LikeIssueState {
  final Paginate<IssueEntity> issuesPagination;
  final bool isLoaded;
  final bool isScrolled;
  Map<String, dynamic> queryParams;
  ScrollController scrollController;

  LikeIssueState({
    this.isScrolled = false,
    required this.scrollController,
    required this.queryParams,
    required this.issuesPagination,
    this.isLoaded = false,
  });

  factory LikeIssueState.empty() => LikeIssueState(
        issuesPagination: Paginate.empty(),
        queryParams: {},
        scrollController: ScrollController(),
      );

  LikeIssueState copyWith({
    Paginate<IssueEntity>? issuesPagination,
    bool? isLoaded,
    bool? isScrolled,
  }) {
    return LikeIssueState(
        scrollController: scrollController,
        isScrolled: isScrolled ?? this.isScrolled,
        queryParams: {},
        issuesPagination: issuesPagination ?? this.issuesPagination,
        isLoaded: isLoaded ?? this.isLoaded);
  }
}
