import 'package:masla_bolo_app/domain/model/issue_json.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_helper.dart';
import 'package:masla_bolo_app/presentation/profile/components/user_profile/user_profile_state.dart';

import '../../../../domain/entities/issue_entity.dart';
import '../../../../domain/model/paginate.dart';
import '../../../../domain/repositories/issue_repository.dart';
import '../../../../main.dart';
import '../../profile_state.dart';
import '../official_profile/official_profile_event.dart';
import '../official_profile/official_profile_state.dart';
import '../user_profile/user_profile_event.dart';

class BaseProfileIssuesService {
  final Map<IssueStatus, MyIssuesState> _allIssues = {};
  late bool _isUser;
  late String _initialUrl;
  IssueRepository issueRepository;
  String role;

  BaseProfileIssuesService({
    required this.issueRepository,
    required this.role,
  }) {
    _isUser = role == "user";
    _initialUrl = _isUser ? "/issues/my/" : "/issues/my_official_issues/";
    if (_isUser) {
      for (final status in userStatus) {
        _allIssues[status] = MyIssuesState.empty();
      }
    } else {
      for (final status in officialStatus) {
        _allIssues[status] = MyIssuesState.empty();
      }
    }
  }

  Future<void> getAllIssues() async {
    await Future.wait(
      _allIssues.keys.map((key) {
        return getMyIssues(status: key, url: _initialUrl);
      }).toList(),
    );
  }

  Future<void> getMyIssues({
    required IssueStatus status,
    String? url,
    bool clearAll = false,
  }) async {
    final issue = _allIssues[status]!.copyWith(isScrolled: false);
    fireEvent(issue, status);
    _allIssues[status] = issue;
    final issues = _allIssues[status]!.issues;
    if (clearAll) {
      issues.results.clear();
    }

    final apiUrl = issues.next != null && !clearAll
        ? issues.next.toString()
        : (url ?? _initialUrl);
    final apiStatus = IssueHelper.getIssueStatus(status);

    issueRepository
        .getIssues(
          url: apiUrl,
          queryParams: {"issue_status": apiStatus},
          previousIssues: issues.results,
        )
        .then((response) => response.fold((error) {
              final issue = _allIssues[status]!.copyWith(
                issues: error.issues,
                isLoaded: true,
                isScrolled: true,
              );
              fireEvent(issue, status);
              _allIssues[status] = issue;
            }, (issuesPagination) {
              distributeIssues(issuesPagination, status);
            }));
  }

  void distributeIssues(Paginate<IssueEntity> result, IssueStatus status) {
    final issue = _allIssues[status]!.copyWith(
      issues: result,
      isLoaded: true,
      isScrolled: true,
    );
    fireEvent(issue, status);
    _allIssues[status] = issue;
  }

  void refreshIssues(IssueStatus status) {
    final issue = _allIssues[status]!.copyWith(isLoaded: false);
    fireEvent(issue, status);
    _allIssues[status] = issue;
    getMyIssues(clearAll: true, status: status);
  }

  void scrollAndCall(IssueStatus status) {
    final result = _allIssues[status]!;
    if (result.issues.next != null && (result.isScrolled == true)) {
      getMyIssues(status: status);
    }
  }

  void fireEvent(MyIssuesState issue, IssueStatus status) {
    if (_isUser) {
      eventBus.fire(UserProfileEvent(issue, status));
    } else {
      eventBus.fire(OfficialProfileEvent(issue, status));
    }
  }
}
