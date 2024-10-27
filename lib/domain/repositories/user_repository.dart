import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/user_failure.dart';

import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<UserFailure, UserEntity>> updateUser(
    UserEntity user,
  );
  Future<Either<UserFailure, UserEntity>> getProfile();
  Future<Either<UserFailure, bool>> deleteUser(
    int userId,
  );
}
