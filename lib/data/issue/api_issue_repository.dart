import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/repositories/issue_repository.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/domain/model/issue_json.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

class ApiIssueRepository implements IssueRepository {
  final NetworkRepository networkRepository;
  ApiIssueRepository(this.networkRepository);

  @override
  Future<List<IssueEntity>> getIssues({
    Map<String, dynamic>? queryParams,
  }) async {
    final response =
        await networkRepository.get(url: '/issues/', extraQuery: queryParams);
    final data = parseList(response.data["results"], IssueJson.fromJson)
        .map((json) => json.toDomain())
        .toList();
    return data;
  }

  @override
  Future<IssueEntity> getIssueyId({
    required int issueId,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await networkRepository.get(
      url: '/issues/$issueId',
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
      url: '/issues/${issue.id}',
      data: issue.toIssueJson(),
    );
    final data = IssueJson.fromJson(response.data).toDomain();
    return data;
  }

  @override
  Future<bool> deleteIssue(int issueId) async {
    await networkRepository.delete(url: '/issues/$issueId');
    return true;
  }

  @override
  Future<IssueEntity> likeUnlikeIssue(
    int issueId,
  ) async {
    final response =
        await networkRepository.get(url: '/comments/$issueId/like');
    final data = IssueJson.fromJson(response.data).toDomain();
    return data;
  }
}
