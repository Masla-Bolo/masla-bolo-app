import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.empty());

  onInit() {
    emit(state.copyWith(panelOffsetX: 1.sw, bottomBarOffset: 0.005.sh));
  }

  void onDragUpdate(DragUpdateDetails details) {
    final newPanelOffset =
        (state.panelOffsetX + details.delta.dx).clamp(0.sw, 1.sw);
    if (state.panelOffsetX != newPanelOffset) {
      final bottomBarOffset = (state.bottomBarOffset / 2) - newPanelOffset;
      emit(state.copyWith(
          panelOffsetX: newPanelOffset, bottomBarOffset: bottomBarOffset));
    }
  }

  void onDragEnd() {
    if (state.panelOffsetX < 0.5.sw) {
      emit(state.copyWith(panelOffsetX: 0, bottomBarOffset: -65));
    } else {
      emit(state.copyWith(panelOffsetX: 1.sw, bottomBarOffset: 0.005.sh));
    }
  }

  void updateServerIndex(int index) {
    emit(state.copyWith(serverIndex: index));
  }
}
