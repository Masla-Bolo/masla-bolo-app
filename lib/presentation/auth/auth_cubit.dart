import 'package:masla_bolo_app/presentation/auth/verify_email/otp.dart';

import '../../di/service_locator.dart';
import '../../domain/repositories/auth_repository.dart';
// import '../../domain/stores/user_store.dart';
import '../../domain/stores/user_store.dart';
import '../../helpers/helpers.dart';
import '../../helpers/strings.dart';
import 'auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../helpers/strings.dart';

import '../../data/local_storage/local_storage_repository.dart';
// import '../../di/service_locator.dart';
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
      final user =
          await authRepository.login(state.user.email!, state.user.password!);

      if (user.emailVerified!) {
        navigation.goToBottomBar();
      } else {
        return sendEmail(user.email!);
      }
    }
  }

  void exitEmailVerification() async {
    if (await showConfirmationDialog(
        "Exit without verifying your email? Your account won’t be activated.")) {
      emit(state.copyWith(otpCodes: []));
      goToRegister();
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
      final email = await authRepository.register(state.user);
      return sendEmail(email);
    }
  }

  Future<void> sendEmail(String email) async {
    return authRepository.sendEmail(email).then((response) {
      if (response) {
        navigation.goToVerifyEmail(email);
      }
    });
  }

  Future<void> verifyMyEmail(String email) {
    final code = state.otpCodes.map((otp) => otp.code).join();
    return authRepository.verifyEmail(email, code).then((response) {
      navigation.goToBottomBar();
      emit(state.copyWith(otpCodes: []));
    });
  }

  void checkPinCompletion(String pin, String email, int index) {
    if (pin.isEmpty) {
      state.otpCodes.removeWhere((otp) => otp.index == index);
      emit(state.copyWith(
        otpCodes: state.otpCodes,
      ));
    } else {
      state.otpCodes.insert(index, Otp(code: pin, index: index));
      if (state.otpCodes.length == 4) {
        emit(state.copyWith(
          otpCodes: state.otpCodes,
        ));
      }
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
