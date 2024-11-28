import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/repositories/user_repository.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/service/image_service.dart';
import '../../domain/repositories/issue_repository.dart';
import '../../domain/stores/user_store.dart';
import '../../helpers/helpers.dart';
import 'profile_navigator.dart';
import 'profile_state.dart';

import '../../di/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigation;
  final UserRepository userRepository;
  final IssueRepository issueRepository;
  final ImageService imageService;
  ProfileCubit(
    this.navigation,
    this.issueRepository,
    this.imageService,
    this.userRepository,
  ) : super(ProfileState.empty());

  Future<void> getUser() async {
    if (state.user.id == null) {
      final user = getIt<UserStore>().appUser;
      emit(state.copyWith(user: user));
    }
  }

  Future<void> showOptions() async {
    final image = await imageService.uploadImage();
    if (image != null) {
      state.user.image = image;
      emit(state.copyWith(user: state.user));
      showToast(
        "Image Uploaded!",
        params: ToastParam(
          toastAlignment: Alignment.bottomCenter,
          image: AppImages.successful,
        ),
      );
      userRepository.updateUser(state.user);
    }
  }

  Future<void> updateProfile() async {
    return userRepository
        .updateUser(state.user)
        .then((response) => response.fold((error) {}, (newUser) {
              emit(state.copyWith(user: newUser));
            }));
  }

  void goToEditProfile() => navigation.goToEditProfile();

  void pop() => navigation.pop();

  goToSettings() {
    navigation.goToSettings();
  }
}
