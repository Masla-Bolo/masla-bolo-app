import '../entities/issue_entity.dart';

abstract class IssueRepository {
  Future<List<IssueEntity>> getIssues({
    Map<String, dynamic>? queryParams,
  });
  Future<IssueEntity> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  });
  Future<IssueEntity> createIssue(IssueEntity issue);
  Future<IssueEntity> updateIssue(IssueEntity issue);
  Future<IssueEntity> likeUnlikeIssue(String issueId);
  Future<bool> deleteIssue(String issueId);
}
