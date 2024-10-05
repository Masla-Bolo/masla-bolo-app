import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_state.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../service/app_service.dart';
import 'components/bottom_bar_icon.dart';

class BottomBarContainer extends StatelessWidget {
  const BottomBarContainer(
      {super.key, required this.cubit, required this.homeCubit});
  final BottomBarCubit cubit;
  final IssueCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 0.8.sw,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: AppColor.black1, blurRadius: 0.25)],
        borderRadius: BorderRadius.circular(30),
      ),
      child: BlocBuilder<BottomBarCubit, BottomBarState>(
          bloc: cubit,
          builder: (context, bottomBarState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
