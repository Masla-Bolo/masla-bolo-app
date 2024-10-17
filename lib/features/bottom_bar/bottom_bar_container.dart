import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_state.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../di/service_locator.dart';
import 'components/bottom_bar_icon.dart';

class BottomBarContainer extends StatelessWidget {
  const BottomBarContainer(
      {super.key, required this.cubit, required this.homeCubit});
  final BottomBarCubit cubit;
  final IssueCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 0.8.sw,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        boxShadow: [
          BoxShadow(color: context.colorScheme.onPrimary, blurRadius: 0.25)
        ],
      ),
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
          bloc: cubit,
          builder: (context, bottomBarState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: bottomBarState.items.mapIndexed((index, item) {
                return BottomBarIcon(
                  item: item,
                  bottomBarCubit: getIt(),
                  index: index,
                );
              }).toList(),
            );
          }),
    );
  }
}
