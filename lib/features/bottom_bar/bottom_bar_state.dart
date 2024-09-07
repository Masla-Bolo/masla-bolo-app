import 'package:masla_bolo_app/features/bottom_bar/components/bottom_bar_item.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home/home_screen.dart';

class BottomBarState {
  List<BottomBarItem> items;
  Widget page;
  int currentIndex;
  BottomBarState({
    required this.page,
    this.currentIndex = 0,
    required this.items,
  });

  factory BottomBarState.empty() => BottomBarState(
        items: BottomBarItem.items,
        currentIndex: 0,
        page: HomeScreen(cubit: getIt()),
      );

  BottomBarState copyWith(
      {Widget? page, int? currentIndex = 0, List<BottomBarItem>? items}) {
    return BottomBarState(
      page: page ?? this.page,
      items: BottomBarItem.items,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
