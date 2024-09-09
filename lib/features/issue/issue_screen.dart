import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/components/issue_field.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/issue/issue_state.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

class IssueScreen extends StatelessWidget {
  const IssueScreen({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit.navigator.context = context;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<IssueCubit, IssueState>(
            bloc: cubit,
            builder: (context, state) {
              return Column(
                children: [
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.goBack();
                          },
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: AppColor.black1),
                        ),
                        20.horizontalSpace,
                        Text(
                          "New Issue",
                          style: Styles.semiBoldStyle(
                              fontSize: 30, color: AppColor.black1),
                        ),
                        const Spacer(),
                        Image.asset(AppImages.link),
                        5.horizontalSpace,
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Form(
                    key: state.key,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // title field like medium
                          IssueField(
                            hintText: "TITLE",
                            onChanged: (val) {},
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
                          // body field like medium
                          IssueField(
                            hintText: "Write about your issue...",
                            onChanged: (val) {},
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
                          // MultiSelectField(
                          //   onChanged: (val) {},
                          //   dropdownItems: const [
                          //     "electeric",
                          //     "water",
                          //     "gas",
                          //     "internet",
                          //   ],
                          //   selectedValues: const [],
                          // )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
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
              );
            }),
      ),
    );
  }
}
