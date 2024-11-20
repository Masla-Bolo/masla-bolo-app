import 'package:flutter/material.dart';

import '../../../../../domain/entities/issue_entity.dart';

class IssuePostParams {
  final int index;
  final int descriptionThreshold;
  final int currentImageIndex;
  final IssueEntity issue;
  final String description;
  final VoidCallback calledSeeMore;
  final PageController pageController;
  final void Function(bool showComment, IssueEntity issue) goToIssueDetail;
  final void Function(IssueEntity issue) likeUnlikeIssue;
  final void Function(int index) updateIndex;

  const IssuePostParams({
    required this.index,
    required this.likeUnlikeIssue,
    required this.pageController,
    required this.goToIssueDetail,
    required this.issue,
    required this.description,
    required this.calledSeeMore,
    required this.currentImageIndex,
    required this.updateIndex,
    required this.descriptionThreshold,
  });
}
