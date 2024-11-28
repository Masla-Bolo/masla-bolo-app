import 'dart:async';

import 'package:masla_bolo_app/presentation/auth/verify_email/otp.dart';

import '../../di/service_locator.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/stores/user_store.dart';
import '../../helpers/helpers.dart';
import '../../service/location_service.dart';
import '../../service/permission_service.dart';
import 'auth_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/strings.dart';

import '../../data/local_storage/local_storage_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final AuthNavigator navigation;
  final LocalStorageRepository localStorageRepository;
  final LocationService locationService;
  final PermissionService permissionService;

  AuthCubit(
    this.authRepository,
    this.navigation,
    this.localStorageRepository,
    this.locationService,
    this.permissionService,
  ) : super(AuthState.initial());

  Future<void> login(String role) async {
    final isValid = state.loginKey.currentState?.validate() ?? false;
    if (isValid) {
      return authRepository
          .login(state.user.email!, state.user.password!, role)
          .then((response) => response.fold((error) {
                showToast(error.error);
              }, (user) {
                if (!(user.verified ?? false) && user.role == "user") {
                  return authRepository
                      .sendEmail(user.email!)
                      .then((response) => response.fold((error) {}, (value) {
                            if (value) {
                              goToVerifyEmail(user.email!);
                            }
                          }));
                } else {
                  navigation.goToBottomBar();
                }
              }));
    }
  }

  Future<void> googleSignIn() async {
    return authRepository
        .googleSignIn()
        .then((response) => response.fold((error) {
              showToast(error.error);
            }, (user) {
              if (user.id != null) {
                navigation.goToBottomBar();
              }
            }));
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
    await permissionService.permissionServiceCall();
    final enabled = await locationService.getLocation();
    if (!enabled) {
      showToast(
          "Location services are disabled, turn on your locations to create an account");
      return;
    } else {
      var role = getIt<UserStore>().appUser.role;
      if (role == null) {
        await localStorageRepository.getValue(roleKey).then(
              (result) => result.fold(
                (error) {
                  showToast("Choose your role first!").then((_) {
                    goToGetStated();
                  });
                },
                (value) {
                  role = value;
                },
              ),
            );
      }
      if (role != null) {
        state.user.role = role;
        state.user.location.latitude = locationService.position.latitude;
        state.user.location.longitude = locationService.position.longitude;
        return authRepository.register(state.user).then(
              (response) => response.fold(
                (error) {
                  showToast(error.error);
                },
                (result) => result.fold(
                  (email) {
                    return authRepository
                        .sendEmail(email)
                        .then((response) => response.fold((error) {
                              showToast(error.error);
                            }, (value) {
                              if (value) {
                                goToVerifyEmail(email);
                              }
                            }));
                  },
                  (user) {
                    navigation.goToBottomBar();
                  },
                ),
              ),
            );
      }
    }
  }

  void startTimer({bool startAgain = false, String email = ""}) {
    if (startAgain && email.isNotEmpty) {
      emit(state.copyWith(timeLeft: 30, canResend: false));
      authRepository.sendEmail(email);
    }
    initializeTimer();
  }

  void initializeTimer() {
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 1) {
        state.timeLeft--;
        emit(state.copyWith(timeLeft: state.timeLeft));
      } else {
        state.canResend = true;
        emit(state.copyWith(canResend: state.canResend));
        state.timer?.cancel();
      }
    });
    emit(state.copyWith(timer: state.timer));
  }

  Future<void> verifyMyEmail(String email) {
    final code = state.otpCodes.map((otp) => otp.code).join();
    return authRepository.verifyEmail(email, code).then(
          (response) => response.fold(
            (error) {
              showToast(error.error);
            },
            (user) {
              navigation.goToBottomBar();
              emit(state.copyWith(otpCodes: []));
            },
          ),
        );
  }

  void checkPinCompletion(String pin, String email, int index) {
    if (pin.isEmpty) {
      state.otpCodes.removeWhere((otp) => otp.index == index);
      emit(state.copyWith(
        otpCodes: state.otpCodes,
      ));
    } else {
      state.otpCodes.insert(index, Otp(code: pin, index: index));
      if (state.otpCodes.length == 6) {
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

  void goToVerifyEmail(String email) {
    navigation.goToVerifyEmail(email);
  }

  @override
  Future<void> close() {
    state.timer?.cancel();
    return super.close();
  }
}
