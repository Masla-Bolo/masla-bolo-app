import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/stores/user_store.dart';

import '../../di/service_locator.dart';

class AuthState {
  final UserEntity user;
  String verifyCode;
  final GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> signUpKey;
  AuthState({
    required this.loginKey,
    required this.verifyCode,
    required this.user,
    required this.signUpKey,
  });

  AuthState copyWith(
          {UserEntity? user,
          String? verifyCode,
          GlobalKey<FormState>? loginKey,
          GlobalKey<FormState>? signUpKey}) =>
      AuthState(
        verifyCode: verifyCode ?? this.verifyCode,
        signUpKey: loginKey ?? this.loginKey,
        loginKey: signUpKey ?? this.signUpKey,
        user: user ?? this.user,
      );

  factory AuthState.initial() => AuthState(
        verifyCode: "",
        loginKey: GlobalKey<FormState>(),
        signUpKey: GlobalKey<FormState>(),
        user: getIt<UserStore>().state,
      );
}
