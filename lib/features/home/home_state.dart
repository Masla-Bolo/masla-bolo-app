import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';

class HomeState {
  UserEntity? user;
  bool isExpanded;
  List<IssueEntity> issues;
  HomeState({
    this.user,
    this.isExpanded = false,
    required this.issues,
  });

  copyWith({
    bool? isExpanded,
    UserEntity? user,
    List<IssueEntity>? issues,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      HomeState(
        isExpanded: isExpanded ?? this.isExpanded,
        issues: issues ?? this.issues,
        user: user ?? this.user,
      );

  factory HomeState.empty() => HomeState(
        user: UserEntity(email: '', id: '', name: ''),
        isExpanded: false,
        issues: [],
      );
}
