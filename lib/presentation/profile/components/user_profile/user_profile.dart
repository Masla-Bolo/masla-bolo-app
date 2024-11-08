import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/presentation/profile/components/base_profile/base_profile_initial_params.dart';
import 'package:masla_bolo_app/presentation/profile/components/base_profile/base_profile_tab.dart';
import 'package:masla_bolo_app/presentation/profile/components/user_profile/user_profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/components/user_profile/user_profile_state.dart';

import '../../../../di/service_locator.dart';
import '../base_profile/base_profile_tab_view.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  final cubit = getIt<UserProfileCubit>();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    if (!cubit.state.isAllIssuesLoaded) {
      cubit.onInit();
    }
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Expanded(
            child: Column(
              children: [
                BaseProfileTab(
                  tabController: tabController,
                  tabHeadings: const [
                    "Pending Issues",
                    "Approved Issues",
                    "Solved Issues",
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: state.allIssues.keys.map((status) {
                      return BaseProfileTabView(
                        status: status,
                        params: BaseProfileInitialParams(
                          allIssues: state.allIssues,
                          goToIssueDetail: (issue) {
                            cubit.goToIssueDetail(issue);
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
