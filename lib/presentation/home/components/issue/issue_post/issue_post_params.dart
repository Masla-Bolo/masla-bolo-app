import 'package:flutter/material.dart';

import '../../../../../domain/entities/issue_entity.dart';
import '../issue_cubit.dart';

class IssuePostParams {
  final int index;
  final int descriptionThreshold;
  final IssueCubit cubit;
  final int currentImageIndex;
  final Function(int index) updateIndex;
  final IssueEntity issue;
  final String description;
  final VoidCallback calledSeeMore;
  final PageController pageController;

  const IssuePostParams({
    required this.index,
    required this.pageController,
    required this.cubit,
    required this.issue,
    required this.description,
    required this.calledSeeMore,
    required this.currentImageIndex,
    required this.updateIndex,
    required this.descriptionThreshold,
  });
}
