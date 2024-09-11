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
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              localStorageRepository
                  .getValue(tokenKey)
                  .then((value) => value.fold(
                        (error) {
                          // navigator.goToBottomBar();
                          navigator.goToGetStarted();
                          // navigator.goToLogin();
                        },
                        (value) {
                          navigator.goToBottomBar();
                        },
                      ))
            });
  }
}
