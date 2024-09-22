import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/issue_failure.dart';

import '../entities/issue_entity.dart';

abstract class IssueRepository {
  Future<Either<IssueFailure, List<IssueEntity>>> getIssues({
    Map<String, dynamic>? queryParams,
  });
  Future<Either<IssueFailure, IssueEntity>> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  });
  Future<Either<IssueFailure, IssueEntity>> createIssue(IssueEntity issue);
  Future<Either<IssueFailure, IssueEntity>> updateIssue(IssueEntity issue);
  Future<Either<IssueFailure, IssueEntity>> likeUnlikeIssue(String issueId);
  Future<Either<IssueFailure, bool>> deleteIssue(String issueId);
}
