import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile_state.dart';

import '../../../../di/service_locator.dart';
import '../../../../helpers/styles/styles.dart';
import '../base_profile/base_profile_initial_params.dart';
import '../base_profile/base_profile_tab.dart';
import '../base_profile/base_profile_tab_view.dart';

class OfficialIssues extends StatefulWidget {
  const OfficialIssues({super.key});

  @override
  State<OfficialIssues> createState() => _UserProfileState();
}

class _UserProfileState extends State<OfficialIssues>
    with SingleTickerProviderStateMixin {
  final cubit = getIt<OfficialProfileCubit>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficialProfileCubit, OfficialProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Expanded(
            child: Column(
              children: [
                AnimatedCrossFade(
                  firstChild: BaseProfileTab(
                    tabController: tabController,
                    tabHeadings: const [
                      "Pending Issues",
                      "Solving Issues",
                      "Your Solved Issues",
                      "Completed Issues",
                    ],
                  ),
                  secondChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.disableIssueSelection();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: context.colorScheme.error,
                            ),
                            child: Center(
                              child: Text(
                                "Disable All Selections",
                                textAlign: TextAlign.center,
                                style: Styles.boldStyle(
                                  fontSize: 12,
                                  color: AppColor.white,
                                  family: FontFamily.varela,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.green,
                          ),
                          child: Center(
                            child: Text(
                              "Move Issues",
                              textAlign: TextAlign.center,
                              style: Styles.boldStyle(
                                fontSize: 12,
                                color: AppColor.white,
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: !state.selectionEnabled
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 500),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    physics: !state.selectionEnabled
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    children: state.allIssues.keys.map((status) {
                      return BaseProfileTabView(
                        status: status,
                        params: BaseProfileInitialParams(
                          allIssues: state.allIssues,
                          selectionEnabled: state.selectionEnabled,
                          toggleIssueSelection: (issue) {
                            cubit.toggleIssueSelection(issue);
                          },
                          goToIssueDetail: (issue) {
                            cubit.goToIssueDetail(issue);
                          },
                          onLongPressIssue: (issue) {
                            if (!state.selectionEnabled) {
                              cubit.onLongPressIssue(issue);
                            }
                          },
                          scrollAndCall: (status) {
                            cubit.scrollAndCall(status);
                          },
                          refreshIssues: (status) {
                            cubit.refreshIssues(status);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
