import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue_helper.dart';
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
                      if (val?.isEmpty == true) {
                        return "Please enter title";
                      }
                      if ((val?.length ?? 0) > 15) {
                        return "Try to brief it :))";
                      }
                      return null;
                    },
                    cursorSize: const Size(2, 40),
                    hintStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: Colors.grey.shade600,
                      family: FontFamily.varela,
                    ),
                    maxLength: 2,
                    textStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: AppColor.black1,
                      family: FontFamily.varela,
                    ),
                  ),
                  10.verticalSpace,
                  IssueField(
                    hintText: "Explain about your issue...",
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
                      family: FontFamily.varela,
                    ),
                    textStyle: Styles.semiBoldStyle(
                      fontSize: 15,
                      color: AppColor.black1,
                      family: FontFamily.varela,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Wrap(
                      spacing: 10.w,
                      direction: Axis.horizontal,
                      children: IssueHelper.categories.map((value) {
                        return GestureDetector(
                          onTap: () {
                            // cubit.updateCategorySelection(value);
                          },
                          child: Chip(
                            backgroundColor: value.isSelected
                                ? AppColor.black1
                                : AppColor.white,
                            label: Text(
                              value.item,
                              style: Styles.boldStyle(
                                fontSize: 15,
                                color: value.isSelected
                                    ? AppColor.white
                                    : AppColor.black1,
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
