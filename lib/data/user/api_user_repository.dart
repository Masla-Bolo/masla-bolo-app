import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/repositories/user_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

import '../../domain/failures/user_failure.dart';
import '../../domain/model/user_json.dart';

class ApiUserRepository implements UserRepository {
  final NetworkRepository networkRepository;
  final UserStore userStore;
  ApiUserRepository(this.networkRepository, this.userStore);

  @override
  Future<Either<UserFailure, bool>> deleteUser(int userId) async {
    final response = await networkRepository.delete(url: '/users/$userId/');
    return response.failed
        ? left(UserFailure(error: response.message))
        : right(true);
  }

  @override
  Future<Either<UserFailure, UserEntity>> updateUser(UserEntity user) async {
    final response = await networkRepository.put(
      url: '/users/${user.id}/',
      data: user.toJson(),
    );
    if (response.failed) {
      return left(UserFailure(error: response.message));
    }
    final newUser = UserJson.fromData(response.data).toDomain();
    userStore.setUser(newUser);
    return right(newUser);
  }

  @override
  Future<Either<UserFailure, UserEntity>> getProfile() async {
    final response = await networkRepository.get(url: '/users/');
    if (response.failed) {
      return left(UserFailure(error: response.message));
    }
    final newUser = UserJson.fromData(response.data['user']).toDomain();
    userStore.setUser(newUser);
    return right(newUser);
  }
}
