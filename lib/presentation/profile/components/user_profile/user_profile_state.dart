import 'package:masla_bolo_app/domain/model/issue_json.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/stores/user_store.dart';
import '../../profile_state.dart';

final userStatus = [
  IssueStatus.notApproved,
  IssueStatus.approved,
  IssueStatus.solved,
];

class UserProfileState {
  UserEntity user;
  Map<IssueStatus, MyIssuesState> allIssues;

  bool isAllIssuesLoaded;
  UserProfileState({
    this.isAllIssuesLoaded = false,
    required this.user,
    required this.allIssues,
  });

  factory UserProfileState.empty() => UserProfileState(
        allIssues: {
          IssueStatus.notApproved: MyIssuesState.empty(),
          IssueStatus.approved: MyIssuesState.empty(),
          IssueStatus.solved: MyIssuesState.empty(),
        },
        user: getIt<UserStore>().appUser,
      );

  copyWith({
    Map<IssueStatus, MyIssuesState>? allIssues,
    UserEntity? user,
    bool? isAllIssuesLoaded,
  }) =>
      UserProfileState(
        isAllIssuesLoaded: isAllIssuesLoaded ?? this.isAllIssuesLoaded,
        allIssues: allIssues ?? this.allIssues,
        user: user ?? this.user,
      );
}
