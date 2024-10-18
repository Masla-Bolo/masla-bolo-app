import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/stores/user_store.dart';

import '../../di/service_locator.dart';
import 'verify_email/otp.dart';

class AuthState {
  final UserEntity user;
  List<Otp> otpCodes;
  final GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> signUpKey;
  AuthState({
    required this.otpCodes,
    required this.loginKey,
    required this.user,
    required this.signUpKey,
  });

  AuthState copyWith(
          {UserEntity? user,
          List<Otp>? otpCodes,
          GlobalKey<FormState>? loginKey,
          GlobalKey<FormState>? signUpKey}) =>
      AuthState(
        otpCodes: otpCodes ?? this.otpCodes,
        signUpKey: loginKey ?? this.loginKey,
        loginKey: signUpKey ?? this.signUpKey,
        user: user ?? this.user,
      );

  factory AuthState.initial() => AuthState(
        otpCodes: [],
        loginKey: GlobalKey<FormState>(),
        signUpKey: GlobalKey<FormState>(),
        user: getIt<UserStore>().state,
      );
}
