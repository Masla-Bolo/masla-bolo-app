import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserStore extends Cubit<UserEntity> {
  UserStore() : super(UserEntity.empty());

  setUser(UserEntity user) => emit(user);
}
