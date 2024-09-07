import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      builder: (context, state) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 150),
          top: 0,
          left: state.panelOffsetX,
          child: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: const BoxDecoration(
              color: AppColor.black1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: List.generate(15, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Panel Item $index',
                      style: const TextStyle(color: AppColor.white),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
