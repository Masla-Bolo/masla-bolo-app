import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/presentation/search_issue/search_issue_state.dart';
import 'package:masla_bolo_app/service/music_service.dart';

import '../../domain/entities/issue_entity.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../helpers/debouncer.dart';
import '../../helpers/helpers.dart';
import '../home/components/issue/issue_detail/issue_detail_initial_params.dart';
import '../home/components/issue/issue_helper.dart';
import 'search_issue_navigator.dart';

class SearchIssueCubit extends Cubit<SearchIssueState> {
  final SearchIssueNavigator navigation;
  final MusicService musicService;
  final IssueRepository issueRepository;
  final Debouncer _debouncer;

  SearchIssueCubit(
    this.issueRepository,
    this.musicService,
    this.navigation,
  )   : _debouncer = Debouncer(delay: const Duration(milliseconds: 800)),
        super(SearchIssueState.empty()) {
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

  void scrollAndCall() {
    if (state.issuesPagination.next != null && state.isScrolled) {
      getIssues();
    }
  }

  Future<void> getIssues(
      {bool clearAll = false, String url = "/issues/"}) async {
    emit(state.copyWith(isScrolled: false));
    if (clearAll && state.issuesPagination.results.isNotEmpty) {
      state.issuesPagination.results.clear();
    }

    final apiUrl = state.issuesPagination.next != null && !clearAll
        ? state.issuesPagination.next.toString()
        : url;

    issueRepository
        .getIssues(
          url: apiUrl,
          queryParams: state.queryParams,
          previousIssues: state.issuesPagination.results,
        )
        .then((response) => response.fold((error) {
              emit(state.copyWith(
                issuesPagination: null,
                isLoaded: true,
                isScrolled: true,
              ));
              showToast(error.error);
            }, (issuesPagination) {
              emit(state.copyWith(
                issuesPagination: issuesPagination,
                isLoaded: true,
                isScrolled: true,
              ));
            }));
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
    emit(state.copyWith(categories: categories, canPop: false));
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
    emit(state.copyWith(sortBy: sortBy, canPop: false));
  }

  void filterInit() {
    emit(state.copyWith(
      previousCategories: state.categoryCopy,
      previousSortBy: state.sortByCopy,
    ));
  }

  Future<void> closeDrawer() async {
    if (!state.hasSelection && state.hasChanges) {
      _resetFiltersAndFetch();
      return;
    }
    if (state.hasChanges) {
      final shouldDiscard = await showConfirmationDialog(
          "Are you sure you want to discard your changes");
      if (shouldDiscard) {
        _closeDrawerAndResetState();
      }
    } else {
      emit(state.copyWith(canPop: true));
    }
  }

  void _resetFiltersAndFetch() {
    emit(state.copyWith(
      categories: state.categories,
      sortBy: state.sortBy,
      isLoaded: false,
      canPop: true,
    ));
    clearAllCategoryFilters();
    clearSortByFilter();
    getIssues(clearAll: true);
  }

  void _closeDrawerAndResetState() {
    emit(state.copyWith(
      categories: state.previousCategoryCopy,
      sortBy: state.previousSortBy,
      canPop: true,
    ));
    navigation.pop();
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
      clearSearchAndFetch();
    }
  }

  void _updateSearchAndFetch(String val) {
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..["search"] = val;
    emit(state.copyWith(isLoaded: false, queryParams: queryParams));
    getIssues(clearAll: true);
  }

  void clearSearchAndFetch() {
    final queryParams = Map<String, dynamic>.from(state.queryParams)
      ..remove("search");
    emit(state.copyWith(isLoaded: false, queryParams: queryParams));
    getIssues(clearAll: true);
  }

  void toggleSeeMore(IssueEntity issue) {
    issue.seeMore = !issue.seeMore;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }

  void likeUnlikeIssue(IssueEntity issue) {
    issue.isLiked = !issue.isLiked;
    issue.likesCount += issue.isLiked ? 1 : -1;
    musicService.play(musicService.likeUnlikeMusic);
    emit(state.copyWith(issuesPagination: state.issuesPagination));
    issueRepository.likeUnlikeIssue(issue.id);
  }

  void goToIssueDetail({bool showComment = false, required IssueEntity issue}) {
    navigation.goToIssueDetail(
        IssueDetailInitialParams(showComment: showComment, issueId: issue.id));
  }

  void updateIndex(int index, IssueEntity issue) {
    state.issuesPagination.results.firstWhere((result) {
      return result.id == issue.id;
    }).currentIndex = index;
    emit(state.copyWith(issuesPagination: state.issuesPagination));
  }

  void goToSearchIssueFilter() {
    navigation.goToSearchIssueFilter();
  }
}
