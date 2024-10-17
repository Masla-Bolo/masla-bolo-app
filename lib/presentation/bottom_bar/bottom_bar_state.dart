import 'components/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home/home_screen.dart';

class BottomBarState {
  List<BottomBarItem> items;
  bool canPop;
  Widget page;
  bool hideBottomBar;
  int currentIndex;
  BottomBarState({
    this.hideBottomBar = false,
    this.canPop = false,
    required this.page,
    this.currentIndex = 0,
    required this.items,
  });

  factory BottomBarState.empty() => BottomBarState(
        items: BottomBarItem.items,
        currentIndex: 0,
        hideBottomBar: false,
        page: const HomeScreen(),
      );

  BottomBarState copyWith(
      {Widget? page,
      int? currentIndex = 0,
      List<BottomBarItem>? items,
      bool? hideBottomBar,
      bool? canPop}) {
    return BottomBarState(
      hideBottomBar: hideBottomBar ?? this.hideBottomBar,
      page: page ?? this.page,
      canPop: canPop ?? this.canPop,
      items: BottomBarItem.items,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
