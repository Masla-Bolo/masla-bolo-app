import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/model/issue_json.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

import '../../domain/failures/issue_failure.dart';

class ApiIssueRepository implements IssueRepository {
  final NetworkRepository networkRepository;
  ApiIssueRepository(this.networkRepository);

  @override
  Future<Either<IssueFailure, List<IssueEntity>>> getIssues({
    Map<String, dynamic>? queryParams,
  }) async {
    final response =
        await networkRepository.get(url: '/issues/', extraQuery: queryParams);
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = parseList(success["results"], IssueJson.fromJson)
          .map((json) => json.toDomain())
          .toList();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await networkRepository.get(
      url: '/issues/$issueId',
      extraQuery: queryParams,
    );
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = IssueJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> createIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.post(
      url: '/issues/',
      data: issue.toIssueJson(),
    );
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = IssueJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> updateIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.put(
      url: '/issues/${issue.id}',
      data: issue.toIssueJson(),
    );
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = IssueJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, bool>> deleteIssue(String issueId) async {
    final response = await networkRepository.delete(url: '/issues/$issueId');
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      return right(true);
    });
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> likeUnlikeIssue(
    String issueId,
  ) async {
    final response =
        await networkRepository.get(url: '/comments/$issueId/like');
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = IssueJson.fromJson(success).toDomain();
      return right(data);
    });
  }
}
