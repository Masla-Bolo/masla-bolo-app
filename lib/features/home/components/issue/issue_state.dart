import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/model/pagination.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';

class IssueState {
  ApiPagination<IssueEntity> issuesPagination;
  bool isLoaded;
  bool isScrolled;
  List<IssueHelper> categories;
  List<IssueHelper> sortBy;
  Map<String, dynamic> queryParams;
  String search;
  IssueState({
    this.search = "",
    this.isLoaded = false,
    this.isScrolled = false,
    this.queryParams = const {},
    required this.sortBy,
    required this.categories,
    required this.issuesPagination,
  });

  copyWith({
    bool? isLoaded,
    bool? isScrolled,
    UserEntity? user,
    String? search,
    Map<String, dynamic>? queryParams,
    ApiPagination<IssueEntity>? issuesPagination,
    List<IssueHelper>? sortBy,
    List<IssueHelper>? categories,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      IssueState(
        isScrolled: isScrolled ?? this.isScrolled,
        search: search ?? this.search,
        isLoaded: isLoaded ?? this.isLoaded,
        sortBy: sortBy ?? this.sortBy,
        categories: categories ?? this.categories,
        issuesPagination: issuesPagination ?? this.issuesPagination,
        queryParams: queryParams ?? this.queryParams,
      );

  factory IssueState.empty() => IssueState(
        sortBy: IssueHelper.sortBy,
        search: "",
        categories: IssueHelper.cloneCategories(),
        issuesPagination: ApiPagination.empty(),
        isLoaded: false,
        queryParams: {},
      );
}
