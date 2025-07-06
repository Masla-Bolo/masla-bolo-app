import 'package:masla_bolo_app/domain/entities/official_entity.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../profile_state.dart';

final officialStatus = [
  IssueStatus.approved,
  IssueStatus.solving,
  IssueStatus.officialSolved,
  IssueStatus.solved,
];

class OfficialProfileState {
  bool isAllIssuesLoaded;
  OfficialEntity official;
  UserEntity user;
  bool selectionEnabled;
  Map<IssueStatus, MyIssuesState> allIssues;

  OfficialProfileState({
    required this.user,
    this.selectionEnabled = false,
    required this.allIssues,
    this.isAllIssuesLoaded = false,
    OfficialEntity? official,
  }) : official = official ?? OfficialEntity.empty();

  factory OfficialProfileState.empty() => OfficialProfileState(
        allIssues: {
          IssueStatus.approved: MyIssuesState.empty(),
          IssueStatus.solving: MyIssuesState.empty(),
          IssueStatus.officialSolved: MyIssuesState.empty(),
          IssueStatus.solved: MyIssuesState.empty(),
        },
        selectionEnabled: false,
        user: UserEntity.empty(),
      );

  copyWith({
    OfficialEntity? official,
    bool? isAllIssuesLoaded,
    bool? selectionEnabled,
    Map<IssueStatus, MyIssuesState>? allIssues,
    UserEntity? user,
  }) =>
      OfficialProfileState(
        selectionEnabled: selectionEnabled ?? this.selectionEnabled,
        isAllIssuesLoaded: isAllIssuesLoaded ?? this.isAllIssuesLoaded,
        allIssues: allIssues ?? this.allIssues,
        user: user ?? this.user,
        official: official ?? this.official,
      );
}
