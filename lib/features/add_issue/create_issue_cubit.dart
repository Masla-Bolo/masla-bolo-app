import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_navigator.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_state.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/helpers/image_helper.dart';
import 'package:masla_bolo_app/service/app_service.dart';

class CreateIssueCubit extends Cubit<CreateIssueState> {
  final CreateIssueNavigator navigator;
  final ImageHelper imageHelper;
  final IssueRepository issueRepository;
  CreateIssueCubit(this.navigator, this.imageHelper, this.issueRepository)
      : super(CreateIssueState.empty());

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
        (result) {
          getIt<ProfileCubit>().appendToPendingIssues(state.issue);
          final bottomarCubit = getIt<BottomBarCubit>();
          bottomarCubit.updateIndex(4);
        },
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
