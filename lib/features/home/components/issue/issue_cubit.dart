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
  final Debouncer _debouncer;

  IssueCubit(this.navigation, this.issueRepository, this.musicService)
      : _debouncer = Debouncer(delay: const Duration(milliseconds: 800)),
        super(IssueState.empty()) {
    _initScrollListener();
  }

  void _initScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!state.scrollController.hasClients) return;
    final threshold = state.scrollController.position.maxScrollExtent * 0.2;
    if (state.scrollController.position.pixels >= threshold) {
      scrollAndCall();
    }
  }

  Future<void> getIssues(
      {bool clearAll = false, String url = "/issues/"}) async {
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

  void refreshIssues() {
    emit(state.copyWith(isLoaded: false));
    getIssues(clearAll: true);
  }

  void scrollAndCall() {
    if (state.issuesPagination.next != null && state.isScrolled) {
      getIssues();
    }
  }

  void likeUnlikeIssue(IssueEntity issue) {
    issue.isLiked = !issue.isLiked;
    issue.likesCount += issue.isLiked ? 1 : -1;
    musicService.play(musicService.likeUnlikeMusic);
    emit(state.copyWith(issuesPagination: state.issuesPagination));
    issueRepository.likeUnlikeIssue(issue.id);
  }

  void pop() => navigation.pop();

  void goToIssueDetail({bool showComment = false, required IssueEntity issue}) {
    navigation.goToIssueDetail(
        IssueDetailInitialParams(showComment: showComment, issue: issue));
  }

  void toggleSeeMore(IssueEntity issue) {
    issue.seeMore = !issue.seeMore;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }

  void applyFilters() {
    final addFilters = state.categories
        .where((value) => value.isSelected)
        .map((value) => value.item)
        .toList();
    final sortBy = state.sortBy.firstWhereOrNull((value) => value.isSelected);

    final queryParams = Map<String, dynamic>.from(state.queryParams);
    if (addFilters.isNotEmpty) {
      queryParams['categories'] = addFilters.join(',');
    }
    if (sortBy?.key != null) {
      queryParams["ordering"] = sortBy!.key;
    }

    emit(state.copyWith(isLoaded: false, queryParams: queryParams));
    getIssues(clearAll: true);
  }

  List<IssueHelper> updateSelection(
      List<IssueHelper> items, IssueHelper value) {
    final updatedItems = items
        .map((item) {
          if (item.item == value.item) {
            return item.copyWith(isSelected: !value.isSelected);
          }
          return item;
        })
        .toList()
        .cast<IssueHelper>();
    return updatedItems;
  }

  void updateCategorySelection(IssueHelper value) {
    final categories = updateSelection(state.categories, value);
    emit(state.copyWith(categories: categories));
  }

  void updateSortBySelection(IssueHelper value) {
    final sortBy = state.sortBy
        .map((sortValue) {
          if (sortValue.item == value.item) {
            return sortValue.copyWith(isSelected: !value.isSelected);
          }
          return sortValue.copyWith(isSelected: false);
        })
        .toList()
        .cast<IssueHelper>();
    emit(state.copyWith(sortBy: sortBy));
  }

  void filterInit() {
    emit(state.copyWith(
      previousCategories: state.categoryCopy,
      previousSortBy: state.sortByCopy,
    ));
  }

  Future<void> closeDrawer(BuildContext context) async {
    if (!state.hasSelection && state.hasChanges) {
      _resetFiltersAndFetch(context);
      return;
    }

    if (state.hasChanges) {
      final shouldDiscard = await showConfirmationDialog(
          "Are you sure you want to discard your changes");
      if (shouldDiscard) {
        if (context.mounted) {
          _closeDrawerAndResetState(context);
        }
      }
    } else {
      Scaffold.of(context).closeEndDrawer();
    }
  }

  void _resetFiltersAndFetch(BuildContext context) {
    emit(state.copyWith(
      categories: state.categories,
      sortBy: state.sortBy,
      isLoaded: false,
    ));
    clearAllCategoryFilters();
    clearSortByFilter();
    getIssues(clearAll: true);
    if (context.mounted) {
      Scaffold.of(context).closeEndDrawer();
    }
  }

  void _closeDrawerAndResetState(BuildContext context) {
    if (context.mounted) {
      Scaffold.of(context).closeEndDrawer();
    }
    emit(state.copyWith(
      categories: state.previousCategoryCopy,
      sortBy: state.previousSortBy,
    ));
  }

  void clearAllCategoryFilters() {
    final categories = state.categories
        .map((category) => category.copyWith(isSelected: false))
        .toList()
        .cast<IssueHelper>();
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..remove("categories");
    emit(state.copyWith(categories: categories, queryParams: queryParams));
  }

  void clearSortByFilter() {
    final sortBy = state.sortBy
        .map((sortValue) => sortValue.copyWith(isSelected: false))
        .toList()
        .cast<IssueHelper>();
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..remove("ordering");
    emit(state.copyWith(sortBy: sortBy, queryParams: queryParams));
  }

  void onChanged(String val) {
    if (val.isNotEmpty) {
      _debouncer.call(() => _updateSearchAndFetch(val));
    } else {
      _debouncer.cancel();
      _clearSearchAndFetch();
    }
  }

  void _updateSearchAndFetch(String val) {
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..["search"] = val;
    emit(state.copyWith(isLoaded: false, queryParams: queryParams));
    getIssues(clearAll: true);
  }

  void _clearSearchAndFetch() {
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..remove("search");
    emit(state.copyWith(isLoaded: false, queryParams: queryParams));
    getIssues(clearAll: true);
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

  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }

  void updateIndex(int index, IssueEntity issue) {
    state.issuesPagination.results.firstWhere((result) {
      return result.id == issue.id;
    }).currentIndex = index;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }
}
