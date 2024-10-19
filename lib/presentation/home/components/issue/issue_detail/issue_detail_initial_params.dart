import '../../../../../domain/entities/issue_entity.dart';

class IssueDetailInitialParams {
  bool showComment;
  IssueEntity issue;

  IssueDetailInitialParams({
    this.showComment = false,
    required this.issue,
  });
}