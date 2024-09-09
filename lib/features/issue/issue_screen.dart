import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';
import 'package:masla_bolo_app/helpers/widgets/multi_select_field.dart';

class IssueScreen extends StatelessWidget {
  const IssueScreen({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<IssueCubit, IssueState>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  10.verticalSpace,
                  Row(
                    children: [
                      const Icon(Icons.cancel, color: AppColor.black1),
                      5.horizontalSpace,
                      Text(
                        "New Issue",
                        style: Styles.boldStyle(
                            fontSize: 20, color: AppColor.black1),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Center(
                          child: Text("Create"),
                        ),
                      ),
                      5.horizontalSpace,
                    ],
                  ),
                  10.verticalSpace,
                  Form(
                    key: state.key,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InputField(
                            onChanged: (val) {},
                            hintText: "Title",
                          ),
                          10.verticalSpace,
                          InputField(
                            onChanged: (val) {},
                            hintText: "Description",
                          ),
                          MultiSelectField(
                            onChanged: (val) {},
                            dropdownItems: const [
                              "electeric",
                              "water",
                              "gas",
                              "internet",
                            ],
                            selectedValues: const [],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
