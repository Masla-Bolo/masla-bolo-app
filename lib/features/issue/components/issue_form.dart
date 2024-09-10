import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';

import '../../../helpers/styles/app_colors.dart';
import '../../../helpers/styles/styles.dart';
import 'issue_field.dart';

class IssueForm extends StatelessWidget {
  const IssueForm({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueCubit, IssueState>(
        bloc: cubit,
        builder: (context, state) {
          return Form(
            key: state.key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IssueField(
                    hintText: "TITLE",
                    onChanged: (val) {},
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    },
                    cursorSize: const Size(2, 40),
                    hintStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: Colors.grey.shade600,
                    ),
                    maxLength: 2,
                    textStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: AppColor.black1,
                    ),
                  ),
                  10.verticalSpace,
                  IssueField(
                    hintText: "Write about your issue...",
                    onChanged: (val) {},
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your issue description";
                      }
                      return null;
                    },
                    maxLength: null,
                    cursorSize: const Size(2, 15),
                    hintStyle: Styles.mediumStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                    textStyle: Styles.semiBoldStyle(
                      fontSize: 15,
                      color: AppColor.black1,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
