import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';

import '../../domain/stores/user_store.dart';
import '../../service/app_service.dart';

class ProfileState {
  final bool isAllIssuesLoaded;
  final UserEntity user;
  Map<String, MyIssuesState> allIssues;
  ProfileState({
    required this.user,
    required this.allIssues,
    this.isAllIssuesLoaded = false,
  });

  factory ProfileState.empty() => ProfileState(
        allIssues: {
          "not_approved": MyIssuesState.empty(),
          "approved": MyIssuesState.empty(),
          "solved": MyIssuesState.empty(),
        },
        user: getIt<UserStore>().appUser,
      );

  copyWith({
    Map<String, MyIssuesState>? allIssues,
    bool? isAllIssuesLoaded,
    UserEntity? user,
  }) =>
      ProfileState(
        allIssues: allIssues ?? this.allIssues,
        isAllIssuesLoaded: isAllIssuesLoaded ?? this.isAllIssuesLoaded,
        user: user ?? this.user,
      );
}

class MyIssuesState {
  final bool isLoaded;
  final Paginate<IssueEntity> issues;
  final bool isScrolled;

  MyIssuesState({
    required this.issues,
    this.isLoaded = false,
    this.isScrolled = false,
  });

  factory MyIssuesState.empty() => MyIssuesState(issues: Paginate.empty());

  MyIssuesState copyWith({
    Paginate<IssueEntity>? issues,
    bool? isLoaded,
    bool? isScrolled,
  }) =>
      MyIssuesState(
        issues: issues ?? this.issues,
        isLoaded: isLoaded ?? this.isLoaded,
        isScrolled: isScrolled ?? this.isScrolled,
      );
}
