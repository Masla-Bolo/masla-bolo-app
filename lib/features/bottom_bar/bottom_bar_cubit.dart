import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';

import '../../di/service_locator.dart';
import 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  final BottomBarNavigator navigation;
  BottomBarCubit(this.navigation) : super(BottomBarState.empty());

  void updateIndex(int index) {
    if (index == 0) {
      getIt<IssueCubit>().scrollToTop();
    }
    emit(state.copyWith(currentIndex: index, page: state.items[index].page));
  }

  void toggleVisibility() {
    emit(state.copyWith(hideBottomBar: !state.hideBottomBar));
  }

  void exitApp() {
    emit(state.copyWith(canPop: true));
    navigation.exitApp();
  }
}
