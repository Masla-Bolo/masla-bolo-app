import 'package:dartz/dartz.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/failures/auth_failure.dart';
import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/model/user_json.dart';
import 'package:masla_bolo_app/network/network_repository.dart';

import '../../domain/stores/user_store.dart';

class ApiAuthRepository implements AuthRepository {
  final UserStore _userStore;
  final NetworkRepository networkRepository;
  ApiAuthRepository(this._userStore, this.networkRepository);

  @override
  Future<Either<AuthFailure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await networkRepository.post(url: '/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.fold(
        (failure) => left(AuthFailure(error: failure.error)),
        (body) {
          final user = UserJson.fromData(body['result']).toDomain();
          _userStore.setUser(user);
          return right(user);
        },
      );
    } catch (error) {
      return left(AuthFailure(error: 'Unable to login, Error: $error'));
    }
  }

  @override
  Future<Either<AuthFailure, bool>> logout() async {
    return left(AuthFailure(error: 'error'));
  }

  @override
  Future<Either<AuthFailure, UserEntity>> register(UserEntity user) async {
    return left(AuthFailure(error: 'error'));
  }
}
