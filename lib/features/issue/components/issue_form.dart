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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: state.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IssueField(
                    hintText: "TITLE",
                    onChanged: (val) {
                      state.issue.title = val;
                    },
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
                  SizedBox(
                    height: 0.5.sh,
                    child: IssueField(
                      hintText: "Explain about your issue...",
                      onChanged: (val) {
                        state.issue.description = val;
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Describe about your issue";
                        }
                        return null;
                      },
                      maxLength: 7,
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
                  ),
                ],
              ),
            ),
          );
        });
  }
}
