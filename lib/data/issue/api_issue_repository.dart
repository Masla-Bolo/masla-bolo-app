import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/model/paginate.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';
import 'package:masla_bolo_app/network/network_repository.dart';
import 'package:masla_bolo_app/service/utility_service.dart';

class ApiIssueRepository implements IssueRepository {
  final NetworkRepository networkRepository;
  final UtilityService utilityService;
  ApiIssueRepository(this.networkRepository, this.utilityService);

  @override
  Future<Paginate<IssueEntity>> getIssues({
    String url = '/issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);

    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return pagination.copyWith(results: previousIssues);
  }

  @override
  Future<Paginate<IssueEntity>> myIssues({
    String url = '/issues/my/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);

    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return pagination.copyWith(results: previousIssues);
  }

  @override
  Future<Paginate<IssueEntity>> likedIssues({
    String url = '/issues/liked_issues/',
    Map<String, dynamic>? queryParams,
    List<IssueEntity> previousIssues = const [],
  }) async {
    final response =
        await networkRepository.get(url: url, extraQuery: queryParams);

    final pagination =
        Paginate<IssueEntity>.fromJson(response.data, IssueJson.fromJson);
    if (previousIssues.isNotEmpty) {
      previousIssues.addAll(pagination.results);
    } else {
      previousIssues = pagination.results;
    }
    return pagination.copyWith(results: previousIssues);
  }

  @override
  Future<IssueEntity> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await networkRepository.get(
      url: '/issues/$issueId/',
      extraQuery: queryParams,
    );
    final data = IssueJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<IssueEntity> createIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.post(
      url: '/issues/',
      data: issue.toIssueJson(),
    );
    final data = IssueJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<IssueEntity> updateIssue(
    IssueEntity issue,
  ) async {
    final response = await networkRepository.put(
      url: '/issues/${issue.id}/',
      data: issue.toIssueJson(),
    );
    final data = IssueJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<bool> deleteIssue(int issueId) async {
    await networkRepository.delete(url: '/issues/$issueId/');
    return true;
  }

  @override
  Future<void> likeUnlikeIssue(
    int issueId,
  ) async {
    utilityService.addOrRemoveFromQueue(
      issueId,
      () => networkRepository.post(url: '/issues/$issueId/like/'),
    );
  }
}
