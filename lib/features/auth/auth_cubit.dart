import 'package:masla_bolo_app/domain/repositories/auth_repository.dart';
import 'package:masla_bolo_app/features/auth/auth_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final AuthNavigator navigation;
  AuthCubit(this.authRepository, this.navigation) : super(AuthState.initial());

  Future<void> login(
    BuildContext context,
  ) async {
    emit(state.copyWith(isLoading: true));
    // authRepository
    //     .login(state.email, state.password)
    //     .then((result) => result.fold(
    //           (failure) => {
    //             emit(state.copyWith(isLoading: false)),
    //             if (context.mounted)
    //               {
    //                 showToast(failure.error, context),
    //               }
    //           },
    //           (user) => {
    //             emit(state.copyWith(isLoading: false)),
    //             if (context.mounted)
    //               {
    //                 navigation.goToBottomBar(),
    //                 showToast('Logged in successfully!', context),
    //               }
    //           },
    //         ));
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(isLoading: false));
      navigation.goToBottomBar();
    });
  }

  goToRegister() {
    navigation.goToRegister();
  }

  pop() {
    navigation.goToLogin();
  }
}
