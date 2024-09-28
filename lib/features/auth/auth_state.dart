import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';

import '../../service/app_service.dart';

class AuthState {
  final UserEntity user;
  final GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> signUpKey;
  AuthState({
    required this.loginKey,
    required this.user,
    required this.signUpKey,
  });

  AuthState copyWith(
          {UserEntity? user,
          GlobalKey<FormState>? loginKey,
          GlobalKey<FormState>? signUpKey}) =>
      AuthState(
        signUpKey: loginKey ?? this.loginKey,
        loginKey: signUpKey ?? this.signUpKey,
        user: user ?? this.user,
      );

  factory AuthState.initial() => AuthState(
        loginKey: GlobalKey<FormState>(),
        signUpKey: GlobalKey<FormState>(),
        user: getIt<UserStore>().state,
      );
}
