import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';

import '../failures/local_storage_failure.dart';

abstract class LocalStorageRepository {
  Future<Either<LocalStorageFailure, bool>> setValue(String key, String value);
  Future<Either<LocalStorageFailure, String>> getValue(String key);
  Future<Either<LocalStorageFailure, bool>> deleteValue(String key);
  Future<Either<LocalStorageFailure, UserEntity>> getUser(String key);
  Future<Either<LocalStorageFailure, bool>> setUser(
      String key, UserEntity user);
}
