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
  Future<Either<IssueFailure, List<IssueEntity>>> getIssues() async {
    final response = await networkRepository.get(url: '/issues/');
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = parseList(success, IssueJson.fromJson)
          .map((json) => json.toDomain())
          .toList();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, IssueEntity>> createIssue(
    IssueEntity server,
  ) async {
    final response = await networkRepository.post(
      url: '/issues/',
      data: server.toIssueJson(),
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
    IssueEntity server,
  ) async {
    final response = await networkRepository.put(
      url: '/issues/${server.id}',
      data: server.toIssueJson(),
    );
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      final data = IssueJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<IssueFailure, bool>> deleteIssue(String serverId) async {
    final response = await networkRepository.delete(url: '/issues/$serverId');
    return response.fold((failure) {
      return left(IssueFailure(error: failure.error));
    }, (success) {
      return right(true);
    });
  }
}
