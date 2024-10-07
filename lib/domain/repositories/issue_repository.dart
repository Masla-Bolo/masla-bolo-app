import '../entities/issue_entity.dart';
import '../model/pagination.dart';

abstract class IssueRepository {
  Future<ApiPagination<IssueEntity>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
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
