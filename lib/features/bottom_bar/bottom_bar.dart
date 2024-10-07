import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_container.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_state.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/app_service.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.cubit});
  final BottomBarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          return PopScope(
            canPop: state.canPop,
            onPopInvoked: (didPop) async {
              if (didPop || state.hideBottomBar) return;
              if (state.currentIndex != 0) {
                return cubit.updateIndex(0);
              } else {
                if (await showConfirmationDialog(
                        'Do you want to exit the app?') &&
                    context.mounted) {
                  cubit.exitApp();
                }
              }
            },
            child: Scaffold(
              body: state.page,
              bottomNavigationBar:
                  (MediaQuery.of(context).viewInsets.bottom <= 100 &&
                          !state.hideBottomBar)
                      ? BottomBarContainer(
                          cubit: getIt(),
                          homeCubit: getIt(),
                        )
                      : null,
            ),
          );
        });
  }
}
