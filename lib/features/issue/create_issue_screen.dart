import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/components/issue_form.dart';
import 'package:masla_bolo_app/features/issue/components/issue_header.dart';
import 'package:masla_bolo_app/features/issue/issue_cubit.dart';

class CreateIssueScreen extends StatelessWidget {
  const CreateIssueScreen({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            10.verticalSpace,
            IssueHeader(cubit: cubit),
            10.verticalSpace,
            IssueForm(cubit: cubit),
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
        ),
      ),
    );
  }
}
