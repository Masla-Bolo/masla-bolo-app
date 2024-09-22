import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue_detail/issue_detail_state.dart';

import '../../../../../helpers/styles/app_colors.dart';
import '../../../../../helpers/styles/styles.dart';

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
                        icon: const Icon(
                          Icons.thumb_up_alt_outlined,
                          color: AppColor.black1,
                        ),
                        label: Text(
                          cubit.params.issue.likesCount < 1
                              ? 'Likes'
                              : "${cubit.params.issue.likesCount} Likes",
                          style: Styles.boldStyle(
                            fontSize: 12,
                            color: AppColor.black1,
                            family: FontFamily.varela,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          focusNode.requestFocus();
                        },
                        icon: const Icon(
                          Icons.comment,
                          color: AppColor.black1,
                        ),
                        label: Text(
                          cubit.params.issue.commentsCount < 1
                              ? 'comments'
                              : "${cubit.params.issue.commentsCount} comments",
                          style: Styles.boldStyle(
                            fontSize: 14,
                            color: AppColor.black1,
                            family: FontFamily.varela,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              ListView.builder(
                  itemCount: 5,
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.black1,
                            child: Icon(
                              Icons.person_2,
                              color: AppColor.white,
                            ),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "aou49i",
                                    style: Styles.boldStyle(
                                      fontSize: 14,
                                      color: AppColor.black1,
                                      family: FontFamily.varela,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Center(
                                    child: Text(
                                      "This seems a very big issue, I request you all to solve it urgently..",
                                      style: Styles.mediumStyle(
                                        fontSize: 12,
                                        color: AppColor.black1,
                                        family: FontFamily.varela,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        });
  }
}
