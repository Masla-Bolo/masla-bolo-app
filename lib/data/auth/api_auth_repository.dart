import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/model/user_json.dart';
import '../../network/network_repository.dart';

import '../../domain/stores/user_store.dart';

class ApiAuthRepository implements AuthRepository {
  final UserStore userStore;
  final NetworkRepository networkRepository;
  ApiAuthRepository(this.userStore, this.networkRepository);

  @override
  Future<UserEntity> login(
    String email,
    String password,
  ) async {
    final response = await networkRepository.post(url: '/login/', data: {
      'email': email,
      'password': password,
    });
    final user = UserJson.fromData(response.data['user']).toDomain();
    userStore.setUser(user);
    return user;
  }

  @override
  Future<UserEntity> register(UserEntity user) async {
    final response = await networkRepository.post(
      url: '/register/',
      data: user.toUserJson(),
    );
    final registeredUser = UserJson.fromData(response.data['user']).toDomain();
    userStore.setUser(registeredUser);
    return registeredUser;
  }
}
