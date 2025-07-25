import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'animated_image_banner.dart';
import 'issue_blinker.dart';
import '../../../../../../helpers/extensions.dart';

import '../../../../../../helpers/styles/styles.dart';
import '../issue_detail_cubit.dart';
import '../issue_detail_state.dart';
import 'issue_detail_discussion.dart';
import 'issue_detail_slider.dart';

class IssueDetailBody extends StatelessWidget {
  const IssueDetailBody({
    super.key,
    required this.cubit,
  });
  final IssueDetailCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            children: [
              10.verticalSpace,
              IssueDetailSlider(
                onTap: (index) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: AnimatedImageBanner(
                          issue: state.currentIssue,
                          index: index,
                        ),
                      );
                    },
                  );
                },
                issue: state.currentIssue,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.verticalSpace,
                    Text(
                      state.currentIssue.description,
                      style: Styles.mediumStyle(
                        fontSize: 15,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.varela,
                      ),
                    ),
                    10.verticalSpace,
                    Wrap(
                      spacing: 10.w,
                      direction: Axis.horizontal,
                      children: state.currentIssue.categories.map((category) {
                        return Chip(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: context.colorScheme.onPrimary,
                            label: Text(category,
                                style: Styles.semiMediumStyle(
                                  fontSize: 12,
                                  color: context.colorScheme.primary,
                                  family: FontFamily.varela,
                                )));
                      }).toList(),
                    ),
                    IssueBlinker(
                      status: state.currentIssue.status,
                      onStatusChange: (newStatus) {
                        cubit.updateIssueStatus(newStatus);
                      },
                    ),
                    IssueDetailDiscussion(
                      focusNode: state.focusNode,
                      cubit: cubit,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
