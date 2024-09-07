import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/server_failure.dart';

import '../entities/server_entity.dart';

abstract class ServerRepository {
  Future<Either<ServerFailure, List<ServerEntity>>> getServers();
  Future<Either<ServerFailure, ServerEntity>> createServer(ServerEntity server);
  Future<Either<ServerFailure, ServerEntity>> updateServer(ServerEntity server);
  Future<Either<ServerFailure, bool>> deleteServer(String serverId);
}
