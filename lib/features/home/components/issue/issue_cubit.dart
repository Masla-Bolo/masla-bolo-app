import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_navigator.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_detail/issue_detail_initial_params.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/service/music_service.dart';

import '../../../../helpers/debouncer.dart';

class IssueCubit extends Cubit<IssueState> {
  final IssueNavigator navigation;
  final IssueRepository issueRepository;
  final MusicService musicService;
  IssueCubit(this.navigation, this.issueRepository, this.musicService)
      : super(IssueState.empty());

  final debouncer = Debouncer(delay: const Duration(milliseconds: 800));

  getIssues({bool clearAll = false, String url = "/issues/"}) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll) {
      state.issuesPagination.results.clear();
    }

    final apiUrl = state.issuesPagination.next != null && !clearAll
        ? state.issuesPagination.next.toString()
        : url;

    final issuesPagination = await issueRepository.getIssues(
      url: apiUrl,
      queryParams: state.queryParams,
      previousIssues: state.issuesPagination.results,
    );

    emit(state.copyWith(
      issuesPagination: issuesPagination,
      isLoaded: true,
      isScrolled: true,
    ));
  }

  void filterInit() {
    emit(state.copyWith(
      previousCategories: state.categories,
      previousSortBy: state.sortBy,
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
      musicService.play(musicService.likeUnlikeMusic);
    } else {
      issue.likesCount -= 1;
      musicService.play(musicService.likeUnlikeMusic);
    }
    emit(state.copyWith(issuesPagination: state.issuesPagination));
    issueRepository.likeUnlikeIssue(issue.id);
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
    state.queryParams.remove("categories");
    emit(
      state.copyWith(categories: categories),
    );
  }

  void applyFilters() {
    final addFilters = state.categories
        .where((value) => value.isSelected == true)
        .map((value) => value.key)
        .toList();

    if (addFilters.isNotEmpty) {
      state.queryParams['categories'] = addFilters.join(',');
    }

    final sortBy = state.sortBy.firstWhereOrNull((value) => value.isSelected);
    if (sortBy?.key != null) {
      state.queryParams["ordering"] = sortBy!.key;
    }

    if (sortBy?.key == null && addFilters.isNotEmpty) {
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
    final check = state.previousCategories != state.categories ||
        state.previousSortBy != state.sortBy;
    if (check) {
      if (await showConfirmationDialog(
          "Are you sure you want to discard your changes")) {
        if (context.mounted) {
          Scaffold.of(context).closeEndDrawer();
        }
        emit(state.copyWith(
          categories: state.previousCategories,
          sortBy: state.previousSortBy,
        ));
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
    state.queryParams.remove("ordering");
    emit(state.copyWith(sortBy: sortBy));
  }

  void onChanged(String val) {
    if (val.isNotEmpty) {
      debouncer.call(() {
        state.queryParams["search"] = val;
        emit(state.copyWith(isLoaded: false));
        getIssues(clearAll: true);
      });
    } else {
      debouncer.cancel();
      state.queryParams.remove("search");
      emit(state.copyWith(isLoaded: false));
      getIssues(clearAll: true);
    }
  }

  void scrollToTop() {
    if (state.scrollController.hasClients) {
      state.scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
