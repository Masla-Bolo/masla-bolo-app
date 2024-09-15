import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_container.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_state.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.cubit});
  final BottomBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) return;
              if (state.currentIndex != 0) {
                return cubit.updateIndex(0);
              } else {
                if (await showConfirmationDialog(
                        'Do you want to exit the app?', context) &&
                    context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Scaffold(
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  state.page,
                  if (MediaQuery.of(context).viewInsets.bottom <= 100 &&
                      !state.hideBottomBar)
                    Positioned(
                        bottom: 10,
                        child: BottomBarContainer(
                          cubit: getIt(),
                          homeCubit: getIt(),
                        )),
                ],
              ),
            ),
          );
        });
  }
}
