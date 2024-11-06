import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/presentation/profile/profile_cubit.dart';
import 'package:masla_bolo_app/presentation/profile/profile_state.dart';

import '../../../../di/service_locator.dart';
import '../../../../helpers/styles/styles.dart';
import 'user_profile_tab_view.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final cubit = getIt<ProfileCubit>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Expanded(
            child: Column(
              children: [
                Center(
                  child: TabBar(
                      indicatorColor: context.colorScheme.onPrimary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelStyle: Styles.boldStyle(
                        fontSize: 12,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.dmSans,
                      ),
                      labelStyle: Styles.boldStyle(
                        fontSize: 12,
                        color: context.colorScheme.onPrimary,
                        family: FontFamily.dmSans,
                      ),
                      labelPadding:
                          const EdgeInsets.only(bottom: 5, left: 15, right: 15),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      controller: tabController,
                      tabs: [
                        Center(
                          child: Text(
                            'Pending Issues',
                            textAlign: TextAlign.center,
                            style: Styles.boldStyle(
                              fontSize: 15,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela,
                            ),
                          ),
                        ),
                        Center(
                            child: Text(
                          'Approved Issues',
                          textAlign: TextAlign.center,
                          style: Styles.boldStyle(
                            fontSize: 15,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                        )),
                        Center(
                          child: Text(
                            'Solved Issues',
                            textAlign: TextAlign.center,
                            style: Styles.boldStyle(
                              fontSize: 15,
                              color: context.colorScheme.onPrimary,
                              family: FontFamily.varela,
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: state.allIssues.keys.map((status) {
                      return UserProfileTabView(
                        status: status,
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
