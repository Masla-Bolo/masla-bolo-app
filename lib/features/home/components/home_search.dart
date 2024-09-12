import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../helpers/widgets/input_field.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeSearch extends StatelessWidget {
  final HomeCubit cubit;

  HomeSearch({
    super.key,
    required this.cubit,
  });

  final focusNode = FocusNode();
  final controller = TextEditingController();

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
                  SizedBox(
                    height: 35,
                    child: InputField(
                      width: 0.8.sw,
                      focusNode: focusNode,
                      textEditingController: controller,
                      hintText: "find issues here..",
                      onChanged: (val) {},
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      focusNode.requestFocus();
                    },
                    child: Image.asset(
                      AppImages.search,
                      color: AppColor.black1,
                      height: 30,
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ));
        });
  }
}
