import 'package:masla_bolo_app/features/home/components/server_container.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/styles/app_colors.dart';
import '../home_state.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.2.sw,
          height: 1.sh,
          color: const Color.fromRGBO(35, 39, 42, 1),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(10, (index) {
                return BlocBuilder<HomeCubit, HomeState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        cubit.updateServerIndex(index);
                      },
                      child: ServerContainer(
                        isSelected: state.serverIndex == index,
                        content: Text('$index'),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1.sh,
            decoration: const BoxDecoration(
                color: AppColor.black5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(20, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$index'),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
