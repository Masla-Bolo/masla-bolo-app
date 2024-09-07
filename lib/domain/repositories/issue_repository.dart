import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/issue_failure.dart';

import '../entities/issue_entity.dart';

abstract class IssueRepository {
  Future<Either<IssueFailure, List<IssueEntity>>> getIssues();
  Future<Either<IssueFailure, IssueEntity>> createIssue(IssueEntity server);
  Future<Either<IssueFailure, IssueEntity>> updateIssue(IssueEntity server);
  Future<Either<IssueFailure, bool>> deleteIssue(String serverId);
}
