import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/server_entity.dart';
import 'package:masla_bolo_app/domain/repositories/server_repository.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/model/server_json.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

import '../../domain/failures/server_failure.dart';

class ApiServerRepository implements ServerRepository {
  final NetworkRepository networkRepository;
  ApiServerRepository(this.networkRepository);
  @override
  Future<Either<ServerFailure, List<ServerEntity>>> getServers() async {
    final response = await networkRepository.get(url: '/servers/');
    return response.fold((failure) {
      return left(ServerFailure(error: failure.error));
    }, (success) {
      final data = parseList(success, ServerJson.fromJson)
          .map((json) => json.toDomain())
          .toList();
      return right(data);
    });
  }

  @override
  Future<Either<ServerFailure, ServerEntity>> createServer(
    ServerEntity server,
  ) async {
    final response = await networkRepository.post(
      url: '/servers/',
      data: server.toServerJson(),
    );
    return response.fold((failure) {
      return left(ServerFailure(error: failure.error));
    }, (success) {
      final data = ServerJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<ServerFailure, ServerEntity>> updateServer(
    ServerEntity server,
  ) async {
    final response = await networkRepository.put(
      url: '/servers/${server.id}',
      data: server.toServerJson(),
    );
    return response.fold((failure) {
      return left(ServerFailure(error: failure.error));
    }, (success) {
      final data = ServerJson.fromJson(success).toDomain();
      return right(data);
    });
  }

  @override
  Future<Either<ServerFailure, bool>> deleteServer(String serverId) async {
    final response = await networkRepository.delete(url: '/servers/$serverId');
    return response.fold((failure) {
      return left(ServerFailure(error: failure.error));
    }, (success) {
      return right(true);
    });
  }
}
