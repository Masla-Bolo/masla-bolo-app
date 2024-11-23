import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/stores/user_store.dart';
import 'get_started_navigator.dart';
import 'get_started_state.dart';
import '../../helpers/strings.dart';

import '../../data/local_storage/local_storage_repository.dart';
import '../../di/service_locator.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  final GetStartedNavigator navigator;
  final LocalStorageRepository localStorageRepository;
  GetStartedCubit(
    this.navigator,
    this.localStorageRepository,
  ) : super(GetStartedState.empty());

  onInit() {
    localStorageRepository.setValue(getStartedKey, "GET_STARTED");
  }

  void updateIndex(int index) {
    state.pageController.jumpToPage(index);
    emit(state.copyWith(currentPage: index));
  }

  void goToNextPage() {
    if (state.currentPage < state.pages.length - 1) {
      updateIndex(state.currentPage + 1);
    }
  }

  void goToPreviousPage() {
    if (state.currentPage <= state.pages.length - 1) {
      updateIndex(state.currentPage - 1);
    }
  }

  goToLogin() {
    navigator.goToLogin();
    state.currentPage = state.pageController.initialPage;
  }

  selectRole(String role) {
    emit(state.copyWith(selectedRole: role));
    getIt<UserStore>().setUser(
      UserEntity(role: role),
    );
  }

  void exitApp() {
    emit(state.copyWith(canPop: true));
    navigator.exitApp();
  }
}
