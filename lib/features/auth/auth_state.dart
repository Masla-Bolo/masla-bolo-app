import 'package:flutter/material.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/main.dart';

class AuthState {
  bool isLoading;
  final UserEntity user;
  final GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> signUpKey;
  AuthState({
    this.isLoading = false,
    required this.loginKey,
    required this.user,
    required this.signUpKey,
  });

  AuthState copyWith(
          {bool? isLoading,
          UserEntity? user,
          GlobalKey<FormState>? loginKey,
          GlobalKey<FormState>? signUpKey}) =>
      AuthState(
        signUpKey: loginKey ?? this.loginKey,
        loginKey: signUpKey ?? this.signUpKey,
        isLoading: isLoading ?? this.isLoading,
        user: user ?? this.user,
      );

  factory AuthState.initial() => AuthState(
        loginKey: GlobalKey<FormState>(),
        signUpKey: GlobalKey<FormState>(),
        user: getIt<UserStore>().state,
      );
}
