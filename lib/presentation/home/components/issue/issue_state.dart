import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/model/paginate.dart';

class IssueState {
  Paginate<IssueEntity> issuesPagination;
  bool isLoaded;
  bool isScrolled;
  ScrollController scrollController;
  IssueState({
    this.isLoaded = false,
    required this.scrollController,
    this.isScrolled = false,
    required this.issuesPagination,
  });

  int get descriptionThreshold => 55;

  copyWith({
    bool? isLoaded,
    bool? isScrolled,
    Paginate<IssueEntity>? issuesPagination,
    ScrollController? scrollController,
  }) =>
      IssueState(
        scrollController: scrollController ?? this.scrollController,
        isScrolled: isScrolled ?? this.isScrolled,
        isLoaded: isLoaded ?? this.isLoaded,
        issuesPagination: issuesPagination ?? this.issuesPagination,
      );

  factory IssueState.empty() => IssueState(
        scrollController: ScrollController(),
        issuesPagination: Paginate.empty(),
        isLoaded: false,
      );
}
