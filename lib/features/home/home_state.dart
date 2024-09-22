import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';

class HomeState {
  UserEntity? user;
  List<IssueEntity> issues;
  bool isLoading;
  List<IssueHelper> categories;
  List<IssueHelper> sortBy;
  Map<String, dynamic> queryParams;
  String search;
  HomeState({
    this.user,
    this.search = "",
    this.isLoading = false,
    this.queryParams = const {},
    required this.sortBy,
    required this.categories,
    required this.issues,
  });

  copyWith({
    bool? isLoading,
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
        isLoading: isLoading ?? this.isLoading,
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
        categories: IssueHelper.categories,
        issues: [],
        isLoading: false,
        queryParams: {},
      );
}
