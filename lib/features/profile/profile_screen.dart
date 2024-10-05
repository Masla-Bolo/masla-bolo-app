import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/components/profile_tab_view.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import 'profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.cubit});
  final ProfileCubit cubit;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ProfileCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;
    tabController = TabController(length: 4, vsync: this);
    cubit.getUser();
    if (!cubit.state.isLoaded) {
      cubit.getMyIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return SafeArea(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Profile",
                                  style: Styles.boldStyle(
                                    fontSize: 30,
                                    color: AppColor.black1,
                                    family: FontFamily.dmSans,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(state.user.username ?? "",
                                    style: Styles.boldStyle(
                                      fontSize: 15,
                                      color: AppColor.black1,
                                      family: FontFamily.dmSans,
                                    )),
                                Text(
                                  state.user.email ?? "",
                                  style: Styles.boldStyle(
                                    fontSize: 15,
                                    color: AppColor.black1,
                                    family: FontFamily.dmSans,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    cubit.goToSettings();
                                  },
                                  child: const Icon(
                                    Icons.settings,
                                    color: AppColor.black1,
                                    size: 30,
                                  ),
                                ),
                                20.verticalSpace,
                                const CircleAvatar(
                                  backgroundColor: AppColor.black1,
                                  child: Icon(Icons.person_2,
                                      color: AppColor.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        30.verticalSpace,
                        OutlinedButton.icon(
                          onPressed: () {
                            //go to edit profile page
                          },
                          label: Text(
                            'Edit Profile',
                            style: Styles.boldStyle(
                              fontSize: 14,
                              color: AppColor.white,
                              family: FontFamily.varela,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColor.black1,
                            minimumSize: const Size(double.infinity, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Center(
                    child: TabBar(
                        indicatorColor: AppColor.black1,
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelStyle: Styles.boldStyle(
                          fontSize: 12,
                          color: AppColor.black1,
                          family: FontFamily.dmSans,
                        ),
                        labelStyle: Styles.boldStyle(
                          fontSize: 12,
                          color: AppColor.black1,
                          family: FontFamily.dmSans,
                        ),
                        labelPadding: const EdgeInsets.only(
                            bottom: 5, left: 15, right: 15),
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        controller: tabController,
                        tabs: [
                          Center(
                              child: Text(
                            'Approved Issues',
                            textAlign: TextAlign.center,
                            style: Styles.boldStyle(
                              fontSize: 15,
                              color: AppColor.black1,
                              family: FontFamily.varela,
                            ),
                          )),
                          Center(
                            child: Text(
                              'Pending Issues',
                              textAlign: TextAlign.center,
                              style: Styles.boldStyle(
                                fontSize: 15,
                                color: AppColor.black1,
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Completed Issues',
                              textAlign: TextAlign.center,
                              style: Styles.boldStyle(
                                fontSize: 15,
                                color: AppColor.black1,
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Liked Issues',
                              textAlign: TextAlign.center,
                              style: Styles.boldStyle(
                                fontSize: 15,
                                color: AppColor.black1,
                                family: FontFamily.varela,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ProfileTabView(issues: state.issues + state.issues),
                        ProfileTabView(issues: state.issues + state.issues),
                        ProfileTabView(issues: state.issues + state.issues),
                        ProfileTabView(issues: state.issues + state.issues),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
