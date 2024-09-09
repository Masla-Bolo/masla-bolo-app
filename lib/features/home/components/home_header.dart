import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import '../../../helpers/widgets/input_field.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeHeader extends StatefulWidget {
  final HomeCubit cubit;

  const HomeHeader({
    super.key,
    required this.cubit,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    widget.cubit.stream.listen((state) {
      if (state.isExpanded) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: widget.cubit,
      builder: (context, state) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  if (!state.isExpanded)
                    Text(
                      "Masla Bolo",
                      style: Styles.boldStyle(
                        fontSize: 30,
                        color: AppColor.black1,
                      ),
                    ),
                  const Spacer(),
                  SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                    child: SizedBox(
                      height: 35,
                      child: InputField(
                        width: !state.isExpanded ? 0 : 0.7.sw,
                        hintText: "Search here...",
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      !state.isExpanded ? Icons.search : Icons.cancel,
                      color: AppColor.black1,
                    ),
                    onPressed: () {
                      widget.cubit.toggleSearch();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  5.horizontalSpace,
                  GestureDetector(
                    onTap: () => widget.cubit.goToNotification(),
                    child:
                        const Icon(Icons.notifications, color: AppColor.black1),
                  ),
                  10.horizontalSpace,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
