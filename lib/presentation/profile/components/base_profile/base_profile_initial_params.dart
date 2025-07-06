import 'package:masla_bolo_app/domain/entities/issue_entity.dart';

import '../../../../domain/model/issue_json.dart';
import '../../profile_state.dart';

class BaseProfileInitialParams {
  Map<IssueStatus, MyIssuesState> allIssues;
  bool selectionEnabled;
  void Function(IssueStatus status) scrollAndCall;
  void Function(IssueStatus status) refreshIssues;
  void Function(IssueEntity issue) goToIssueDetail;
  void Function(IssueEntity issue)? toggleIssueSelection;
  void Function(IssueEntity issue)? onLongPressIssue;

  BaseProfileInitialParams({
    required this.allIssues,
    this.toggleIssueSelection,
    this.selectionEnabled = false,
    required this.goToIssueDetail,
    this.onLongPressIssue,
    required this.refreshIssues,
    required this.scrollAndCall,
  });
}
