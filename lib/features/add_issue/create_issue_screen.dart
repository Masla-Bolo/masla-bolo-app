import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/add_issue/components/create_issue_form.dart';
import 'package:masla_bolo_app/features/add_issue/components/create_issue_header.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_cubit.dart';
import 'package:masla_bolo_app/features/add_issue/create_issue_state.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

import '../../helpers/styles/app_colors.dart';
import '../../helpers/styles/styles.dart';

class CreateIssueScreen extends StatelessWidget {
  const CreateIssueScreen({super.key, required this.cubit});
  final CreateIssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.verticalSpace,
                    IssueHeader(cubit: cubit),
                    10.verticalSpace,
                    IssueForm(cubit: cubit),
                    20.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: state.categories.slices(7).map((row) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: row.map((value) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.updateSelection(value);
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
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        10.horizontalSpace,
                        Text(
                          "Post as anonymous",
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: AppColor.black1,
                            family: FontFamily.dmSans,
                          ),
                        ),
                        const Spacer(),
                        CupertinoSwitch(
                          value: state.issue.isAnonymous,
                          onChanged: (val) {
                            cubit.changeAnonymous(val);
                          },
                          activeColor: AppColor.black1,
                          onLabelColor: AppColor.black1,
                        ),
                        10.horizontalSpace,
                      ],
                    ),
                    20.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          loader(() => cubit.createIssue());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Text("Create"),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        });
  }
}
