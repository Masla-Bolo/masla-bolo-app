import '../entities/issue_entity.dart';
import '../model/paginate.dart';

abstract class IssueRepository {
  Future<Paginate<IssueEntity>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
  });
  Future<Paginate<IssueEntity>> myIssues({
    String url = '/issues/my/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
  });
  Future<Paginate<IssueEntity>> likedIssues({
    String url = '/issues/liked_issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
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
