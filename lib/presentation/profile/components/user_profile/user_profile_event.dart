import '../../../../domain/model/issue_json.dart';
import '../../profile_state.dart';

class UserProfileEvent {
  MyIssuesState data;
  IssueStatus status;
  UserProfileEvent(this.data, this.status);
}
