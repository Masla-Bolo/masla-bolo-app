import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/domain/stores/user_store.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
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

  Future<void> login(
    BuildContext context,
  ) async {
    final isValid = state.loginKey.currentState?.validate() ?? false;
    if (isValid) {
      emit(state.copyWith(isLoading: true));
      authRepository
          .login(state.user.email!, state.user.password!)
          .then((result) => result.fold(
                (failure) => {
                  emit(state.copyWith(isLoading: false)),
                },
                (user) => {
                  emit(state.copyWith(isLoading: false)),
                  navigation.goToBottomBar(),
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
          return;
        },
        (value) => role = value,
      );
    }

    if (role != null) {
      state.user.role = role;
      emit(state.copyWith(isLoading: true));
      final result = await authRepository.register(state.user);
      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false));
        },
        (user) {
          emit(state.copyWith(isLoading: false));
          navigation.goToBottomBar();
        },
      );
    }
  }

  void goToRegister() {
    navigation.goToRegister();
  }

  void pop() {
    navigation.goToLogin();
  }

  void goToGetStated() {
    navigation.goToGetStarted();
    getIt<GetStartedCubit>().state.pageController.jumpToPage(1);
  }
}
