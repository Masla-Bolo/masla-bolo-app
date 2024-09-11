import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/get_started/get_started_navigator.dart';
import 'package:masla_bolo_app/features/get_started/get_started_state.dart';

class GetStartedCubit extends Cubit<GetStartedState> {
  final GetStartedNavigator navigator;
  GetStartedCubit(this.navigator) : super(GetStartedState.empty());

  void updateIndex(int index) {
    state.pageController.jumpToPage(index);
    emit(state.copyWith(currentPage: index));
  }

  void goToNextPage() {
    if (state.currentPage < state.pages.length - 1) {
      updateIndex(state.currentPage + 1);
    }
  }

  goToLogin() => navigator.goToLogin();

  selectRole(String role) => emit(state.copyWith(selectedRole: role));
}
