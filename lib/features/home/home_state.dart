import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/features/home/components/issue_filters.dart';

class HomeState {
  UserEntity? user;
  bool isExpanded;
  List<IssueEntity> issues;
  List<IssueFilters> categories;
  List<IssueFilters> sortBy;
  HomeState({
    this.user,
    required this.sortBy,
    required this.categories,
    this.isExpanded = true,
    required this.issues,
  });

  copyWith({
    bool? isExpanded,
    UserEntity? user,
    List<IssueEntity>? issues,
    List<IssueFilters>? sortBy,
    List<IssueFilters>? categories,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      HomeState(
        sortBy: sortBy ?? this.sortBy,
        categories: categories ?? this.categories,
        isExpanded: isExpanded ?? this.isExpanded,
        issues: issues ?? this.issues,
        user: user ?? this.user,
      );

  factory HomeState.empty() => HomeState(
        sortBy: IssueFilters.sortBy,
        user: UserEntity(email: '', id: '', name: ''),
        categories: IssueFilters.categories,
        isExpanded: true,
        issues: [],
      );
}
