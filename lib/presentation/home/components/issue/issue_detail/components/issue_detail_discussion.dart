import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_helper.dart';
import '../../../../../../helpers/styles/app_images.dart';
import 'emergency_contact/emergency_contact_button.dart';
import 'emergency_contact/emergency_contact_sheet.dart';
import 'issue_comment/issue_comments.dart';
import '../issue_detail_cubit.dart';
import '../issue_detail_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../../../../../../helpers/styles/styles.dart';

class IssueDetailDiscussion extends StatelessWidget {
  const IssueDetailDiscussion({
    super.key,
    required this.focusNode,
    required this.cubit,
  });
  final IssueDetailCubit cubit;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: [
              10.verticalSpace,
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: GestureDetector(
                          onTap: () {
                            cubit.likeUnlikeIssue();
                          },
                          child: SvgPicture.asset(
                            state.currentIssue.isLiked
                                ? AppImages.raised
                                : AppImages.raise,
                            height: 30,
                            colorFilter: ColorFilter.mode(
                              context.colorScheme.onPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        label: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.likeUnlikeIssue();
                              },
                              child: Text(
                                state.currentIssue.isLiked ? "Raised" : "Raise",
                                style: Styles.boldStyle(
                                  fontSize: 15,
                                  color: context.colorScheme.onPrimary,
                                  family: FontFamily.varela,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.currentIssue.likesCount < 1
                                  ? "Raise"
                                  : "${IssueHelper.getLikesCount(state.currentIssue.likesCount)} Raises",
                              style: Styles.mediumStyle(
                                fontSize: 12,
                                color: context.colorScheme.onPrimary,
                                family: FontFamily.varela,
                              ),
                            ),
                            10.horizontalSpace,
                            Text(
                              state.currentIssue.commentsCount == 1
                                  ? "1 comment"
                                  : "${state.currentIssue.commentsCount} comments",
                              style: Styles.mediumStyle(
                                fontSize: 12,
                                color: context.colorScheme.onPrimary,
                                family: FontFamily.varela,
                              ),
                            ),
                          ],
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: context.colorScheme.secondary
                                  .withOpacity(0.5),
                              width: 0.05,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              if (state.currentIssue.emergencyContact != null)
                EmergencyContactButton(
                  onTap: () {
                    showEmergencyContactBottomSheet(
                      context,
                      state.currentIssue.emergencyContact!,
                    );
                  },
                ),
              10.verticalSpace,
              Divider(
                color: context.colorScheme.onPrimary,
                endIndent: 10,
                thickness: 0.2,
              ),
              10.verticalSpace,
              IssueComments(
                comments: state.comments,
                cubit: cubit,
              ),
            ],
          );
        });
  }
}
