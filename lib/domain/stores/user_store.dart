import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage/local_storage_repository.dart';
import '../../helpers/strings.dart';
import '../entities/user_entity.dart';

class UserStore extends Cubit<UserEntity> {
  final LocalStorageRepository localStorageRepository;
  UserEntity _user = UserEntity.empty();
  UserEntity get appUser => _user;
  UserStore(this.localStorageRepository) : super(UserEntity.empty());

  setUser(UserEntity user) async {
    await localStorageRepository.setUser(userKey, user).then((_) {
      _user = user;
      emit(_user);
    });
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
