import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/failures/auth_failure.dart';

import '../entities/location.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity>> login(
      String email, String password, String role);
  Future<Either<AuthFailure, Either<String, UserEntity>>> register(
      UserEntity user);
  Future<Either<AuthFailure, bool>> sendEmail(String email);
  Future<Either<AuthFailure, UserEntity>> verifyEmail(
      String email, String code);
  Future<Either<AuthFailure, UserEntity>> googleSignIn(Location location);
}
