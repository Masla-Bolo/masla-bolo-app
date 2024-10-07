import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_navigator.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../../../helpers/debouncer.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigation;
  final IssueRepository issueRepository;
  IssueCubit(this.navigation, this.issueRepository) : super(IssueState.empty());

  final debouncer = Debouncer(delay: const Duration(seconds: 2));
  Map<String, dynamic> queryParams = {};

  getIssues({bool clearAll = false}) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll) {
      state.issuesPagination.results.clear();
    }

    final url = state.issuesPagination.next != null && !clearAll
        ? state.issuesPagination.next.toString()
        : "/issues/";

    final issuesPagination = await issueRepository.getIssues(
      url: url,
      queryParams: queryParams,
      previousIssues: state.issuesPagination.results,
    );

    emit(state.copyWith(
      issuesPagination: issuesPagination,
      isLoaded: true,
      isScrolled: true,
    ));
  }

  refreshIssues() {
    emit(state.copyWith(isLoaded: false));
    getIssues(clearAll: true);
  }

  scrollAndCall() {
    if (state.issuesPagination.next != null && state.isScrolled) {
      getIssues();
    }
  }

  void likeUnlikeIssue(IssueEntity issue) {
    issue.isLiked = !issue.isLiked;
    if (issue.isLiked) {
      issue.likesCount += 1;
    } else {
      issue.likesCount -= 1;
    }
    emit(state.copyWith(issuesPagination: state.issuesPagination));
    issueRepository.likeUnlikeIssue(issue.id);
  }

  debounce(String value) {
    if (value.isEmpty) {
      queryParams.remove("search");
      emit(state.copyWith(isLoaded: false));
      getIssues(clearAll: true);
    } else {
      debouncer.call(() {
        emit(state.copyWith(isLoaded: false));
        queryParams["search"] = value;
        getIssues(clearAll: true);
      });
    }
  }

  pop() {
    navigation.pop();
  }

  goToIssueDetail({bool showComment = false, required IssueEntity issue}) {
    navigation.goToIssueDetail(
        IssueDetailInitialParams(showComment: showComment, issue: issue));
  }

  void updateCategorySelection(IssueHelper value) {
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
    final categories = state.categories.map((category) {
      category.isSelected = false;
      return category;
    }).toList();
    queryParams.remove("categories");
    emit(
      state.copyWith(
        categories: categories,
      ),
    );
  }

  void applyFilters() {
    final addFilters = state.categories
        .where((value) => value.isSelected == true)
        .map((value) => value.key)
        .toList();

    if (addFilters.isNotEmpty) {
      queryParams.addAll({
        'categories': addFilters.join(','),
      });
    }

    final sortBy = state.sortBy.firstWhere((value) => value.isSelected);
    if (sortBy.key != null) {
      queryParams.addAll({"ordering": sortBy.key});
    }

    if (sortBy.key == null && addFilters.isNotEmpty) {
      showToast("Select a filter to apply");
    } else {
      emit(state.copyWith(isLoaded: false));
      getIssues(clearAll: true);
    }
  }

  void updateSortBySelection(IssueHelper value) {
    final sortBy = state.sortBy.map((sortValue) {
      if (sortValue.item == value.item) {
        sortValue.isSelected = !value.isSelected;
      } else if (sortValue.item != value.item) {
        sortValue.isSelected = false;
      }
      return sortValue;
    }).toList();

    emit(
      state.copyWith(
        sortBy: sortBy,
      ),
    );
  }

  void closeDrawer(BuildContext context) async {
    if (state.categories.any((value) => value.isSelected == true) ||
        state.sortBy.any((value) => value.isSelected == true)) {
      if (await showConfirmationDialog(
          "Are you sure you want to discard your changes")) {
        if (context.mounted) {
          Scaffold.of(context).closeEndDrawer();
        }
        clearAllCategoryFilters();
        clearSortByFilter();
      }
    } else {
      Scaffold.of(context).closeEndDrawer();
    }
  }

  void clearSortByFilter() {
    final sortBy = state.sortBy.map((sortValue) {
      sortValue.isSelected = false;
      return sortValue;
    }).toList();
    queryParams.remove("ordering");
    emit(
      state.copyWith(
        sortBy: sortBy,
      ),
    );
  }

  goToNotification() {
    navigation.goToNotification();
  }
}
