import '../entities/issue_entity.dart';

abstract class IssueRepository {
  Future<List<IssueEntity>> getIssues({
    Map<String, dynamic>? queryParams,
  });
  Future<List<IssueEntity>> myIssues({
    Map<String, dynamic>? queryParams,
  });
  Future<IssueEntity> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  });
  Future<IssueEntity> createIssue(IssueEntity issue);
  Future<IssueEntity> updateIssue(IssueEntity issue);
  Future<void> likeUnlikeIssue(int issueId);
  Future<bool> deleteIssue(int issueId);
}
