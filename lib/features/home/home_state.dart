import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';

class HomeState {
  UserEntity? user;
  List<IssueEntity> issues;
  bool isLoaded;
  List<IssueHelper> categories;
  List<IssueHelper> sortBy;
  Map<String, dynamic> queryParams;
  String search;
  HomeState({
    this.user,
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
      HomeState(
        search: search ?? this.search,
        isLoaded: isLoaded ?? this.isLoaded,
        sortBy: sortBy ?? this.sortBy,
        categories: categories ?? this.categories,
        issues: issues ?? this.issues,
        user: user ?? this.user,
        queryParams: queryParams ?? this.queryParams,
      );

  factory HomeState.empty() => HomeState(
        sortBy: IssueHelper.sortBy,
        search: "",
        user: UserEntity(email: '', id: 0, username: ''),
        categories: IssueHelper.cloneCategories(),
        issues: [],
        isLoaded: false,
        queryParams: {},
      );
}
