import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../helpers/widgets/input_field.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeSearch extends StatelessWidget {
  final HomeCubit cubit;

  const HomeSearch({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  2.horizontalSpace,
                  InputField(
                    width: 0.8.sw,
                    hintText: "Search problems here..",
                    onChanged: (val) {},
                  ),
                  const Spacer(),
                  Image.asset(AppImages.search),
                  20.horizontalSpace,
                ],
              ));
        });
  }
}
