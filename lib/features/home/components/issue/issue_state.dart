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
  IssueState({
    this.isLoaded = false,
    this.isScrolled = false,
    required this.sortBy,
    required this.categories,
    required this.issuesPagination,
  });

  copyWith({
    bool? isLoaded,
    bool? isScrolled,
    UserEntity? user,
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
        isLoaded: isLoaded ?? this.isLoaded,
        sortBy: sortBy ?? this.sortBy,
        categories: categories ?? this.categories,
        issuesPagination: issuesPagination ?? this.issuesPagination,
      );

  factory IssueState.empty() => IssueState(
        sortBy: IssueHelper.sortBy,
        categories: IssueHelper.cloneCategories(),
        issuesPagination: ApiPagination.empty(),
        isLoaded: false,
      );
}
