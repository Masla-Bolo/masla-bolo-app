import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import '../../main.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final AuthNavigator navigation;
  final LocalStorageRepository localStorageRepository;
  AuthCubit(this.authRepository, this.navigation, this.localStorageRepository)
      : super(AuthState.initial());

  void onInit() {
    emit(state.copyWith(
      loginKey: GlobalKey<FormState>(),
      signUpKey: GlobalKey<FormState>(),
    ));
  }

  Future<void> login() async {
    final isValid = state.loginKey.currentState?.validate() ?? false;
    if (isValid) {
      return authRepository
          .login(state.user.email!, state.user.password!)
          .then((result) => result.fold(
                (failure) => {},
                (user) {
                  navigation.goToBottomBar();
                },
              ));
    }
  }

  Future<void> register() async {
    final isValid = state.signUpKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var role = getIt<UserStore>().state.role;
    if (role == null) {
      final result = await localStorageRepository.getValue(roleKey);
      result.fold(
        (error) {
          return goToGetStated();
        },
        (value) => role = value,
      );
    }

    if (role != null) {
      state.user.role = role;
      return authRepository.register(state.user).then(
            (result) => result.fold(
              (failure) => {},
              (user) => navigation.goToBottomBar(),
            ),
          );
    }
  }

  void goToRegister() {
    navigation.goToRegister();
  }

  void goToLogin() {
    navigation.goToLogin();
  }

  void goToGetStated() {
    navigation.goToGetStarted();
  }
}
