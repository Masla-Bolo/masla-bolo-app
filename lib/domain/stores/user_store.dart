import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import '../../data/local_storage/local_storage_repository.dart';

class UserStore extends Cubit<UserEntity> {
  final LocalStorageRepository localStorageRepository;
  UserEntity _user = UserEntity.empty();
  UserEntity get appUser => _user;
  UserStore(this.localStorageRepository) : super(UserEntity.empty());

  setUser(UserEntity user) {
    localStorageRepository.setUser(userKey, user);
    _user = user;
    emit(user);
  }

  Future<UserEntity?> getUser() async {
    if (appUser.id != null) {
      return appUser;
    }
    return await localStorageRepository.getUser(userKey).then(
          (result) => result.fold(
            (left) {
              return null;
            },
            (user) => user,
          ),
        );
  }
}
