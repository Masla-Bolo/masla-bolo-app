import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/issue_coordinates_entity.dart';
import 'package:masla_bolo_app/domain/failures/issue_failure.dart';

import '../entities/issue_entity.dart';
import '../model/issue_json.dart';
import '../model/paginate.dart';

abstract class IssueRepository {
  Future<Either<IssueFailure, Paginate<IssueEntity>>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
  });

  Future<Either<IssueFailure, List<IssueCoordinatesEntity>>>
      getIssuesCoordinates();

  Future<Either<IssueFailure, Paginate<IssueEntity>>> myIssues({
    String url = '/issues/my/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
  });
  Future<Either<IssueFailure, Paginate<IssueEntity>>> likedIssues({
    String url = '/issues/liked_issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues,
  });
  Future<Either<IssueFailure, IssueEntity>> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  });
  Future<Either<IssueFailure, IssueEntity>> createIssue(IssueEntity issue);
  Future<Either<IssueFailure, IssueEntity>> updateIssue(IssueEntity issue);
  Future<Either<IssueFailure, bool>> updateIssueStatus(
    int id,
    IssueStatus status,
  );
  Future<Either<IssueFailure, void>> likeUnlikeIssue(int issueId);
  Future<Either<IssueFailure, bool>> deleteIssue(int issueId);
}
