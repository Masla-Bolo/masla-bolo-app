import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<String> register(UserEntity user);
  Future<bool> sendEmail(String email);
  Future<UserEntity> verifyEmail(String email, String code);
  Future<UserEntity> googleSignIn();
}
