import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/repositories/user_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

import '../../domain/model/user_json.dart';

class ApiUserRepository implements UserRepository {
  final NetworkRepository networkRepository;
  final UserStore userStore;
  ApiUserRepository(this.networkRepository, this.userStore);

  @override
  Future<bool> deleteUser(int userId) async {
    await networkRepository.delete(url: '/users/$userId/');
    return true;
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    final response = await networkRepository.put(
      url: '/users/${user.id}/',
      data: user.toUserJson(),
    );
    final newUser = UserJson.fromData(response.data).toDomain();
    userStore.setUser(newUser);
    return newUser;
  }

  @override
  Future<UserEntity> getProfile() async {
    final response = await networkRepository.get(url: '/users/');
    final newUser = UserJson.fromData(response.data['user']).toDomain();
    userStore.setUser(newUser);
    return newUser;
  }
}
