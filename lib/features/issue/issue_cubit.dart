import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';
import 'package:masla_bolo_app/features/issue/issue_navigator.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigator;
  final ImageHelper imageHelper;
  final IssueRepository issueRepository;
  IssueCubit(this.navigator, this.imageHelper, this.issueRepository)
      : super(IssueState.empty());
  void goBack() {
    navigator.navigation.pop();
  }

  Future<void> showOptions(BuildContext context) async {
    final image = await imageHelper.showOptions(context);
    if (image != null) {}
  }

  Future<void> createIssue() async {
    final isValid = state.key.currentState?.validate() ?? false;
    if (isValid && state.categories.any((value) => value.isSelected)) {
      final categories = state.categories
          .where((val) => val.isSelected)
          .map((value) => value.item)
          .toList();
      state.issue.categories = categories;
      return issueRepository.createIssue(state.issue).then(
            (result) => goBack(),
          );
    }
  }

  void updateSelection(IssueHelper value) {
    final categories = state.categories.map((category) {
      if (category.item == value.item) {
        category.isSelected = !value.isSelected;
      }
      return category;
    }).toList();

    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void clearAllCategoryFilters() {
    final categories = state.categories;
    categories.map((category) {
      category.isSelected = false;
    });
    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void changeAnonymous(bool val) {
    state.issue.isAnonymous = val;
    emit(state.copyWith(issue: state.issue));
  }
}
