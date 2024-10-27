import 'package:dartz/dartz.dart';

import '../../domain/entities/issue_entity.dart';
import '../../domain/failures/issue_failure.dart';
import '../../domain/model/paginate.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../domain/model/issue_json.dart';
import '../../network/network_repository.dart';
import '../../service/utility_service.dart';

class ApiIssueRepository implements IssueRepository {
  final NetworkRepository networkRepository;
  final UtilityService utilityService;
  ApiIssueRepository(this.networkRepository, this.utilityService);

  @override
  Future<Either<IssueFailure, Paginate<IssueEntity>>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);

    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return right(pagination.copyWith(results: previousIssues));
  }

  @override
  Future<Either<IssueFailure, Paginate<IssueEntity>>> myIssues({
    String url = '/issues/my/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);

    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return right(pagination.copyWith(results: previousIssues));
  }

  @override
  Future<Either<IssueFailure, Paginate<IssueEntity>>> likedIssues({
    String url = '/issues/liked_issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return right(pagination.copyWith(results: previousIssues));
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await networkRepository.get(
      url: '/issues/$issueId/',
      extraQuery: queryParams,
    );
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final data = IssueJson.fromJson(response.data).toDomain();
    return right(data);
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> createIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.post(
      url: '/issues/',
      data: issue.toIssueJson(),
    );
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final data = IssueJson.fromJson(response.data).toDomain();
    return right(data);
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> updateIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.put(
      url: '/issues/${issue.id}/',
      data: issue.toIssueJson(),
    );
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final data = IssueJson.fromJson(response.data).toDomain();
    return right(data);
  }

  @override
  Future<Either<IssueFailure, bool>> deleteIssue(int issueId) async {
    final response = await networkRepository.delete(url: '/issues/$issueId/');
    return response.failed
        ? left(IssueFailure(error: response.message))
        : right(true);
  }

  @override
  Future<Either<IssueFailure, void>> likeUnlikeIssue(
    int issueId,
  ) async {
    utilityService.addOrRemoveFromQueue(
      issueId,
      () => networkRepository.post(url: '/issues/$issueId/like/'),
    );
    return right(null);
  }
}
