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
  Future<String> register(UserEntity user) async {
    final response = await networkRepository.post(
      url: '/register/',
      data: user.toUserJson(),
    );
    return response.data["email"];
  }

  @override
  Future<bool> sendEmail(String email) async {
    await networkRepository.get(url: '/send-email-verification/', extraQuery: {
      'email': email,
    });
    return true;
  }

  @override
  Future<UserEntity> verifyEmail(String email, String code) async {
    final response = await networkRepository.post(url: '/verify-email/', data: {
      'email': email,
      'code': code,
    });
    final user = UserJson.fromData(response.data['user']).toDomain();
    userStore.setUser(user);
    return user;
  }
}
