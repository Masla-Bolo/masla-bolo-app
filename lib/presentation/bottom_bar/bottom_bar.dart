import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import '../../helpers/helpers.dart';
import 'bottom_bar_container.dart';
import 'bottom_bar_cubit.dart';
import 'bottom_bar_state.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.cubit});
  final BottomBarCubit cubit;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    widget.cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: widget.cubit,
        builder: (context, state) {
          return PopScope(
            canPop: state.canPop,
            onPopInvokedWithResult: (didPop, _) async {
              if (didPop) return;
              if (state.currentIndex != 0) {
                return widget.cubit.updateIndex(state.currentIndex - 1);
              } else {
                if (await showConfirmationDialog(
                        'Do you want to exit the app?') &&
                    context.mounted) {
                  widget.cubit.exitApp();
                }
              }
            },
            child: Scaffold(
              body: state.page,
              bottomNavigationBar:
                  (MediaQuery.of(context).viewInsets.bottom <= 100)
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
