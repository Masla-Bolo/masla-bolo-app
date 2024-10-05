import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_helper.dart';

class IssueState {
  List<IssueEntity> issues;
  bool isLoaded;
  List<IssueHelper> categories;
  List<IssueHelper> sortBy;
  Map<String, dynamic> queryParams;
  String search;
  IssueState({
    this.search = "",
    this.isLoaded = false,
    this.queryParams = const {},
    required this.sortBy,
    required this.categories,
    required this.issues,
  });

  copyWith({
    bool? isLoaded,
    UserEntity? user,
    String? search,
    Map<String, dynamic>? queryParams,
    List<IssueEntity>? issues,
    List<IssueHelper>? sortBy,
    List<IssueHelper>? categories,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      IssueState(
        search: search ?? this.search,
        isLoaded: isLoaded ?? this.isLoaded,
        sortBy: sortBy ?? this.sortBy,
        categories: categories ?? this.categories,
        issues: issues ?? this.issues,
        queryParams: queryParams ?? this.queryParams,
      );

  factory IssueState.empty() => IssueState(
        sortBy: IssueHelper.sortBy,
        search: "",
        categories: IssueHelper.cloneCategories(),
        issues: [],
        isLoaded: false,
        queryParams: {},
      );
}
