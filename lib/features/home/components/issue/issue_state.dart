import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';

class IssueState {
  Paginate<IssueEntity> issuesPagination;
  bool isLoaded;
  bool isScrolled;
  List<IssueHelper> categories;
  List<IssueHelper> sortBy;
  List<IssueHelper> previousCategories;
  List<IssueHelper> previousSortBy;
  Map<String, dynamic> queryParams;

  ScrollController scrollController;
  IssueState({
    this.isLoaded = false,
    required this.scrollController,
    required this.queryParams,
    this.isScrolled = false,
    this.previousCategories = const [],
    this.previousSortBy = const [],
    required this.sortBy,
    required this.categories,
    required this.issuesPagination,
  });

  int get descriptionThreshold => 55;

  copyWith({
    int? currentImage,
    bool? isLoaded,
    bool? isScrolled,
    UserEntity? user,
    Paginate<IssueEntity>? issuesPagination,
    List<IssueHelper>? sortBy,
    Map<String, dynamic>? queryParams,
    List<IssueHelper>? categories,
    PageController? pageController,
    List<IssueHelper>? previousSortBy,
    ScrollController? scrollController,
    List<IssueHelper>? previousCategories,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      IssueState(
          scrollController: scrollController ?? this.scrollController,
          isScrolled: isScrolled ?? this.isScrolled,
          isLoaded: isLoaded ?? this.isLoaded,
          sortBy: sortBy ??
              this.sortBy.map((e) => e.copyWith()).toList().cast<IssueHelper>(),
          categories: categories ??
              this
                  .categories
                  .map((e) => e.copyWith())
                  .toList()
                  .cast<IssueHelper>(),
          issuesPagination: issuesPagination ?? this.issuesPagination,
          previousCategories: previousCategories ??
              this
                  .previousCategories
                  .map((e) => e.copyWith())
                  .toList()
                  .cast<IssueHelper>(),
          previousSortBy: previousSortBy ??
              this
                  .previousSortBy
                  .map((e) => e.copyWith())
                  .toList()
                  .cast<IssueHelper>(),
          queryParams: queryParams ?? this.queryParams);

  factory IssueState.empty() => IssueState(
        sortBy: IssueHelper.sortBy,
        scrollController: ScrollController(),
        queryParams: {},
        categories: IssueHelper.cloneInitialCategories(),
        issuesPagination: Paginate.empty(),
        isLoaded: false,
      );

  final deepEq = const DeepCollectionEquality().equals;
  bool get hasChanges =>
      !deepEq(previousCategories, categories) ||
      !deepEq(previousSortBy, sortBy);
  bool get hasSelection =>
      categories.any((val) => val.isSelected) ||
      sortBy.any((val) => val.isSelected);

  List<IssueHelper> get categoryCopy =>
      categories.map((e) => e.copyWith()).toList().cast<IssueHelper>();
  List<IssueHelper> get sortByCopy =>
      sortBy.map((e) => e.copyWith()).toList().cast<IssueHelper>();
  List<IssueHelper> get previousCategoryCopy =>
      previousCategories.map((e) => e.copyWith()).toList().cast<IssueHelper>();
  List<IssueHelper> get previousSortByCopy =>
      previousSortBy.map((e) => e.copyWith()).toList().cast<IssueHelper>();
}
