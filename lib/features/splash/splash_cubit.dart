import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/features/splash/splash_navigator.dart';
import 'package:masla_bolo_app/helpers/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final LocalStorageRepository localStorageRepository;
  SplashCubit(this.navigator, this.localStorageRepository)
      : super(SplashState());

  onInit() {
    emit(state.copyWith(isLoaded: true));
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              localStorageRepository.getValue(getStartedKey).then((result) => {
                    result.fold(
                      (error) {
                        navigator.goToGetStarted();
                      },
                      (success) => {
                        localStorageRepository.getValue(tokenKey).then(
                              (value) => value.fold(
                                (error) {
                                  navigator.goToLogin();
                                },
                                (value) {
                                  navigator.goToBottomBar();
                                },
                              ),
                            ),
                      },
                    ),
                  }),
            }).then((_) {
      emit(state.copyWith(isLoaded: false));
    });
  }
}
