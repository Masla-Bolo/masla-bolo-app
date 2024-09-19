import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/get_started/componenets/get_started_role.dart';
import 'package:masla_bolo_app/features/get_started/componenets/get_started_about.dart';

class GetStartedState {
  List<Widget> pages;
  int currentPage;
  String selectedRole;
  PageController pageController;

  GetStartedState({
    required this.pages,
    this.selectedRole = "user",
    required this.currentPage,
    required this.pageController,
  });

  factory GetStartedState.empty() => GetStartedState(
        currentPage: 0,
        selectedRole: "user",
        pageController: PageController(
          initialPage: 0,
        ),
        pages: [const GetStartedAbout(), const GetStartedRole()],
      );

  GetStartedState copyWith({
    List<Widget>? pages,
    int? currentPage,
    String? selectedRole,
    PageController? pageController,
  }) =>
      GetStartedState(
        pages: pages ?? this.pages,
        currentPage: currentPage ?? this.currentPage,
        selectedRole: selectedRole ?? this.selectedRole,
        pageController: pageController ?? this.pageController,
      );
}
