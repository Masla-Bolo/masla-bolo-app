import '../../../../domain/model/issue_json.dart';
import '../../profile_state.dart';

class OfficialProfileEvent {
  MyIssuesState data;
  IssueStatus status;
  OfficialProfileEvent(this.data, this.status);
}
