import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> updateUser(
    UserEntity user,
  );
  Future<bool> deleteUser(
    int userId,
  );
}
