import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../helpers/widgets/rounded_image.dart';
import 'components/profile_tab_view.dart';
import 'profile_cubit.dart';
import '../../helpers/extensions.dart';
import '../../helpers/styles/styles.dart';

import '../../di/service_locator.dart';
import 'profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final cubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    cubit.getUser();
    if (!cubit.state.isAllIssuesLoaded) {
      cubit.getAllIssues();
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
                                    color: context.colorScheme.onPrimary,
                                    family: FontFamily.dmSans,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(state.user.username ?? "",
                                    style: Styles.boldStyle(
                                      fontSize: 15,
                                      color: context.colorScheme.onPrimary,
                                      family: FontFamily.dmSans,
                                    )),
                                Text(
                                  state.user.email ?? "",
                                  style: Styles.boldStyle(
                                    fontSize: 15,
                                    color: context.colorScheme.onPrimary,
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
                                  child: Icon(
                                    Icons.settings,
                                    color: context.colorScheme.onPrimary,
                                    size: 30,
                                  ),
                                ),
                                20.verticalSpace,
                                GestureDetector(
                                  onTap: () async {
                                    await cubit.showOptions();
                                  },
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        RoundedImage(
                                          imageUrl: state.user.image,
                                          iconText: state.user.username,
                                          radius: 25.w,
                                        ),
                                        Positioned(
                                            right: 4,
                                            bottom: 4,
                                            child: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color:
                                                  context.colorScheme.secondary,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // 30.verticalSpace,
                        // OutlinedButton.icon(
                        //   onPressed: () {
                        //     cubit.goToEditProfile();
                        //   },
                        //   label: Text(
                        //     'Edit Profile',
                        //     style: Styles.boldStyle(
                        //       fontSize: 14,
                        //       color: context.colorScheme.primary,
                        //       family: FontFamily.varela,
                        //     ),
                        //   ),
                        //   style: OutlinedButton.styleFrom(
                        //     backgroundColor: context.colorScheme.onPrimary,
                        //     minimumSize: const Size(double.infinity, 35),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
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
                        labelPadding: const EdgeInsets.only(
                            bottom: 5, left: 15, right: 15),
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
                        return ProfileTabView(
                          status: status,
                        );
                      }).toList(),
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
