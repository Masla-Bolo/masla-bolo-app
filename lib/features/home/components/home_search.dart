import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../../helpers/widgets/input_field.dart';
import 'issue/issue_cubit.dart';
import 'issue/issue_state.dart';

class HomeSearch extends StatelessWidget {
  final IssueCubit cubit;

  HomeSearch({
    super.key,
    required this.cubit,
  });

  final focusNode = FocusNode();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueCubit, IssueState>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: InputField(
                        borderRadius: 20,
                        focusNode: focusNode,
                        textEditingController: controller,
                        hintText: "find issues here..",
                        onChanged: (val) {
                          cubit.debounce(val);
                        },
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: () {
                      focusNode.requestFocus();
                    },
                    child: Image.asset(
                      AppImages.search,
                      color: AppColor.black3,
                      height: 30,
                    ),
                  ),
                  10.horizontalSpace,
                ],
              ));
        });
  }
}
