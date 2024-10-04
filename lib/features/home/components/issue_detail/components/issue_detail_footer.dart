import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_cubit.dart';

import '../../../../../helpers/styles/app_colors.dart';
import '../../../../../helpers/widgets/input_field.dart';
import '../issue_detail_state.dart';

class IssueDetailFooter extends StatelessWidget {
  const IssueDetailFooter({super.key, required this.cubit});
  final IssueDetailCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 3, 12, 8),
                child: InputField(
                  focusNode: state.focusNode,
                  textEditingController: state.commentController,
                  disableOnTapOutside: true,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      cubit.onChanged(val);
                    }
                  },
                  hintText: "write a comment...",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (state.commentController.text.isNotEmpty) {
                  cubit.addComment();
                }
              },
              child: const Icon(
                Icons.send,
                color: AppColor.black1,
              ),
            ),
            15.horizontalSpace,
          ],
        );
      },
    );
  }
}
