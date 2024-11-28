import 'dart:async';

import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/stores/user_store.dart';

import '../../di/service_locator.dart';
import 'verify_email/otp.dart';

class AuthState {
  final UserEntity user;
  List<Otp> otpCodes;
  bool canResend;
  int timeLeft;
  String get role => getIt<UserStore>().appUser.role!;
  final GlobalKey<FormState> loginKey;
  final GlobalKey<FormState> signUpKey;
  Timer? timer;
  AuthState({
    this.canResend = false,
    required this.timeLeft,
    required this.otpCodes,
    required this.loginKey,
    required this.user,
    required this.signUpKey,
    this.timer,
  });

  AuthState copyWith(
          {UserEntity? user,
          List<Otp>? otpCodes,
          Timer? timer,
          bool? canResend,
          int? timeLeft,
          GlobalKey<FormState>? loginKey,
          GlobalKey<FormState>? signUpKey}) =>
      AuthState(
        timer: timer ?? this.timer,
        timeLeft: timeLeft ?? this.timeLeft,
        canResend: canResend ?? this.canResend,
        otpCodes: otpCodes ?? this.otpCodes,
        signUpKey: loginKey ?? this.loginKey,
        loginKey: signUpKey ?? this.signUpKey,
        user: user ?? this.user,
      );

  factory AuthState.initial() => AuthState(
        otpCodes: [],
        timeLeft: 30,
        loginKey: GlobalKey<FormState>(),
        signUpKey: GlobalKey<FormState>(),
        user: getIt<UserStore>().state,
      );
}
