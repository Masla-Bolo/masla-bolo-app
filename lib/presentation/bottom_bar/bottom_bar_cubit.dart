import 'package:masla_bolo_app/presentation/bottom_bar/components/bottom_bar_item.dart';

import '../../domain/stores/user_store.dart';
import 'bottom_bar_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/components/issue/issue_cubit.dart';

import '../../di/service_locator.dart';
import 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  final BottomBarNavigator navigation;
  BottomBarCubit(this.navigation) : super(BottomBarState.empty()) {
    onInit();
  }

  onInit() {
    final user = getIt<UserStore>().appUser;
    if (user.role == "official") {
      emit(state.copyWith(items: BottomBarItem.officialItems));
    } else {
      emit(state.copyWith(items: BottomBarItem.userItems));
    }
  }

  void updateIndex(int index) {
    if (index == 0) {
      getIt<IssueCubit>().scrollToTop();
    }
    emit(state.copyWith(currentIndex: index, page: state.items[index].page));
  }

  void exitApp() {
    emit(state.copyWith(canPop: true));
    navigation.exitApp();
  }
}
