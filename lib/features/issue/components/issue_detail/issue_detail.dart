import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/components/issue_detail_categories.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/components/issue_detail_discussion.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/components/issue_detail_slider.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_cubit.dart';
import 'package:masla_bolo_app/features/issue/components/issue_detail/issue_detail_state.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/header.dart';
import 'package:masla_bolo_app/helpers/widgets/input_field.dart';

class IssueDetail extends StatefulWidget {
  const IssueDetail({super.key, required this.cubit});
  final IssueDetailCubit cubit;

  @override
  State<IssueDetail> createState() => _IssueDetailState();
}

class _IssueDetailState extends State<IssueDetail> {
  late IssueDetailCubit cubit;
  final focusNode = FocusNode();
  final controller = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
    if (cubit.params.showComment) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailCubit, IssueDetailState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                10.verticalSpace,
                Header(
                  title: "ISSUE DETAIL",
                  onBackTap: () {
                    widget.cubit.goBack();
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        10.verticalSpace,
                        IssueDetailSlider(
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.verticalSpace,
                              Text(
                                "Severage Issue near Nazimabad".toUpperCase(),
                                style: Styles.boldStyle(
                                  fontSize: 20,
                                  color: AppColor.black1,
                                  family: FontFamily.dmSans,
                                ),
                              ),
                              5.verticalSpace,
                              Text(
                                "There has been a severe drainage issue reported near Nazimabad, where overflowing sewage is causing significant inconvenience for residents and passersby. The stagnant water has not only led to foul odors but also poses health risks, especially with the spread of waterborne diseases. Local authorities have been notified, but the situation remains unresolved, leading to growing frustration among the community. Immediate attention is required to prevent further escalation of the problem.",
                                style: Styles.mediumStyle(
                                  fontSize: 18,
                                  color: AppColor.grey,
                                  family: FontFamily.varela,
                                ),
                              ),
                              10.verticalSpace,
                              const IssueDetailCategories(),
                              IssueDetailDiscussion(focusNode: focusNode)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 3, 12, 8),
                        child: InputField(
                          focusNode: focusNode,
                          disableOnTapOutside: true,
                          textEditingController: controller,
                          onChanged: (val) {},
                          hintText: "write a comment...",
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.send,
                      color: AppColor.black1,
                    ),
                    15.horizontalSpace,
                  ],
                )
              ],
            )),
          );
        });
  }
}
