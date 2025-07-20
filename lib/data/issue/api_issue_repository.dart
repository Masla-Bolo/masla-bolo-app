import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/data/local_storage/local_storage_repository.dart';
import 'package:masla_bolo_app/helpers/strings.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_helper.dart';

import '../../domain/entities/issue_coordinates_entity.dart';
import '../../domain/entities/issue_entity.dart';
import '../../domain/failures/issue_failure.dart';
import '../../domain/failures/local_storage_failure.dart';
import '../../domain/model/issue_coordinates_model.dart';
import '../../domain/model/paginate.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../domain/model/issue_json.dart';
import '../../network/network_repository.dart';
import '../../service/utility_service.dart';
import 'dart:async' show unawaited;

class ApiIssueRepository implements IssueRepository {
  final NetworkRepository networkRepository;
  final LocalStorageRepository localStorageRepository;
  final UtilityService utilityService;
  ApiIssueRepository(
    this.networkRepository,
    this.utilityService,
    this.localStorageRepository,
  );

  @override
  Future<Either<IssueFailure, Paginate<IssueEntity>>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);
    if (response.failed) {
      return _handleFailedRequestWithCache(
        cacheKey: allIssuesKey,
        getCacheData: () => localStorageRepository.getIssues(allIssuesKey),
        networkError: response.message,
      );
    }

    final pagination = updatedPagination(
      previousIssues: previousIssues,
      data: response.data,
      localKey: allIssuesKey,
    );

    return right(pagination);
  }

  @override
  Future<Either<IssueFailure, List<IssueCoordinatesEntity>>>
      getIssuesCoordinates() async {
    final response = await networkRepository.get(url: "/issues/locations/");
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final data = response.data as List;
    final issueCoordinates =
        data.map((e) => IssueCoordinatesModel.fromJson(e).toDomain()).toList();

    return right(issueCoordinates);
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
      return _handleFailedRequestWithCache(
        cacheKey: myIssuesKey,
        getCacheData: () => localStorageRepository.getIssues(myIssuesKey),
        networkError: response.message,
      );
    }

    final pagination = updatedPagination(
      previousIssues: previousIssues,
      data: response.data,
      localKey: myIssuesKey,
    );

    return right(pagination);
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
      return _handleFailedRequestWithCache(
        cacheKey: likedIssuesKey,
        getCacheData: () => localStorageRepository.getIssues(likedIssuesKey),
        networkError: response.message,
      );
    }

    final pagination = updatedPagination(
      previousIssues: previousIssues,
      data: response.data,
      localKey: likedIssuesKey,
    );

    return right(pagination);
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
      return _handleFailedRequestWithCache(
        cacheKey: issueId.toString(),
        getCacheData: () => localStorageRepository.getIssue(issueId.toString()),
        networkError: response.message,
      );
    }

    final data = IssueJson.fromJson(response.data).toDomain();
    unawaited(localStorageRepository.setIssue(issueId.toString(), data));
    return right(data);
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> createIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.post(
      url: '/issues/',
      data: issue.createIssueToJson(),
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
      data: issue.createIssueToJson(),
    );
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    final data = IssueJson.fromJson(response.data).toDomain();
    return right(data);
  }

  @override
  Future<Either<IssueFailure, bool>> updateIssueStatus(
    int id,
    IssueStatus status,
  ) async {
    final response = await networkRepository.patch(
      url: '/issues/${id.toString()}/change-status/',
      data: {
        'new_status': IssueHelper.getIssueStatus(status),
      },
    );
    if (response.failed) {
      return left(IssueFailure(error: response.message));
    }
    return right(true);
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

  Future<Either<IssueFailure, T>> _handleFailedRequestWithCache<T>({
    required String cacheKey,
    required Future<Either<LocalStorageFailure, T>> Function() getCacheData,
    required String networkError,
  }) async {
    final cacheResult = await getCacheData();

    return cacheResult.fold(
      (cacheError) {
        return left(IssueFailure(
          error:
              'Network Error: $networkError\nCache Error: ${cacheError.error}',
        ));
      },
      (cachedData) => left(IssueFailure(
        error: 'Network Error: $networkError\nUsing cached data',
        issues: cachedData is Paginate<IssueEntity> ? cachedData : null,
        issue: cachedData is IssueEntity ? cachedData : null,
      )),
    );
  }

  Paginate<IssueEntity> updatedPagination({
    required List<IssueEntity> previousIssues,
    required Map<String, dynamic> data,
    required String localKey,
  }) {
    Paginate<IssueEntity> pagination =
        Paginate<IssueEntity>.fromJson(data, IssueJson.fromJson);
    final updatedResults = previousIssues.isEmpty
        ? pagination.results
        : [...previousIssues, ...pagination.results];
    pagination = pagination.copyWith(results: updatedResults);
    unawaited(localStorageRepository.saveIssues(localKey, pagination));
    return pagination;
  }
}
