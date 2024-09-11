import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_state.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  final GetStartedNavigator navigator;
  final LocalStorageRepository localStorageRepository;
  GetStartedCubit(this.navigator, this.localStorageRepository)
      : super(GetStartedState.empty());

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

  goToLogin() => navigator.goToLogin();

  selectRole(String role) => emit(state.copyWith(selectedRole: role));
}
