import 'package:masla_bolo_app/features/bottom_bar/components/bottom_bar_item.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bottom_bar_cubit.dart';
import '../bottom_bar_state.dart';

class BottomBarIcon extends StatefulWidget {
  const BottomBarIcon({
    super.key,
    required this.item,
    required this.index,
    required this.bottomBarCubit,
  });
  final BottomBarItem item;
  final int index;
  final BottomBarCubit bottomBarCubit;

  @override
  State<BottomBarIcon> createState() => _BottomBarIconState();
}

class _BottomBarIconState extends State<BottomBarIcon> {
  late BottomBarCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = widget.bottomBarCubit;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, BottomBarState>(
        bloc: cubit,
        builder: (context, state) {
          bool isSelected = state.currentIndex == widget.index;
          return GestureDetector(
            onTap: () => cubit.updateIndex(widget.index),
            child: Image.asset(
              widget.item.image,
              height: 25,
              color: isSelected
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.secondary.withOpacity(0.6),
            ),
          );
        });
  }
}
