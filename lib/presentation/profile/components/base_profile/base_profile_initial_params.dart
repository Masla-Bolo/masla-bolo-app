import 'package:masla_bolo_app/domain/entities/issue_entity.dart';

import '../../../../domain/model/issue_json.dart';
import '../../profile_state.dart';

class BaseProfileInitialParams {
  Map<IssueStatus, MyIssuesState> allIssues;
  void Function(IssueStatus status) scrollAndCall;
  void Function(IssueStatus status) refreshIssues;
  void Function(IssueEntity issue) goToIssueDetail;

  BaseProfileInitialParams({
    required this.allIssues,
    required this.goToIssueDetail,
    required this.refreshIssues,
    required this.scrollAndCall,
  });
}
