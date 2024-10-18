import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/stores/user_store.dart';
import 'auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/strings.dart';

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
          showToast("Select your role first");
          return goToGetStated();
        },
        (value) => role = value,
      );
    }

    if (role != null) {
      state.user.role = role;
      return authRepository.register(state.user).then(
        (userEmail) {
          authRepository.sendEmail(userEmail).then((response) {
            if (response) {
              navigation.goToVerifyEmail(userEmail);
              showToast(
                "An Email Verifcation Code has been sent to your email",
                params: ToastParam(
                  hideImage: true,
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          });
        },
      );
    }
  }

  Future<void> verifyMyEmail(String email) {
    return authRepository.verifyEmail(email, state.verifyCode).then((response) {
      navigation.goToBottomBar();
    });
  }

  void checkPinCompletion(String pin, String email) {
    state.verifyCode += pin;
    if (state.verifyCode.length == 4) {
      emit(state.copyWith(verifyCode: state.verifyCode));
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
