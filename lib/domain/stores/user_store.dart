import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage/local_storage_repository.dart';
import '../../helpers/strings.dart';
import '../entities/user_entity.dart';

class UserStore extends Cubit<UserEntity> {
  final LocalStorageRepository _localStorageRepository;

  UserStore(this._localStorageRepository) : super(UserEntity.empty());

  UserEntity get appUser => state;

  Future<void> setUser(UserEntity user) async {
    try {
      final result = await _localStorageRepository.setUser(userKey, user);
      result.fold(
        (error) => {},
        (_) => emit(user),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserEntity?> getUser() async {
    if (state.id != null) return state;
    final result = await _localStorageRepository.getUser(userKey);
    return result.fold(
      (error) => null,
      (user) {
        emit(user);
        return user;
      },
    );
  }
}
