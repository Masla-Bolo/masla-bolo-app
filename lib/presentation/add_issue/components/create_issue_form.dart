import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../create_issue_cubit.dart';
import '../create_issue_state.dart';
import '../../../helpers/extensions.dart';

import '../../../helpers/styles/styles.dart';
import 'create_issue_field.dart';

class IssueForm extends StatelessWidget {
  const IssueForm({super.key, required this.cubit});
  final CreateIssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
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
                      return null;
                    },
                    cursorSize: const Size(2, 40),
                    hintStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: context.colorScheme.secondary.withOpacity(0.9),
                      family: FontFamily.varela,
                    ),
                    maxLength: 2,
                    textStyle: Styles.semiBoldStyle(
                      fontSize: 40,
                      color: context.colorScheme.onPrimary,
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
                        color: context.colorScheme.secondary.withOpacity(0.9),
                        family: FontFamily.varela,
                      ),
                      textStyle: Styles.mediumStyle(
                        fontSize: 15,
                        color: context.colorScheme.onPrimary,
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
