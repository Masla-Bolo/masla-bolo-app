import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import '../../data/local_storage/local_storage_repository.dart';
import '../../di/service_locator.dart';
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
          .then((user) {
        navigation.goToBottomBar();
      });
    }
  }

  // register karte waqt role assign karna hai, agar user pehle se hi role choose karlia toh woh local mein save hojata hai, phir app band karke
  // ayga toh woh save rahega, baad mein role save rahe isiliye ham local mein save karwarahe.
  Future<void> register() async {
    final isValid = state.signUpKey.currentState?.validate() ?? false;
    if (!isValid) return;

    var role = getIt<UserStore>().appUser.role;
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
            (result) => navigation.goToBottomBar(),
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
