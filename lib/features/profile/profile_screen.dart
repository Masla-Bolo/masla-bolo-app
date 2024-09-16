import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/profile/profile_cubit.dart';
import 'package:masla_bolo_app/helpers/styles/app_colors.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            Text("aou49i",
                                style: Styles.boldStyle(
                                  fontSize: 15,
                                  color: AppColor.black1,
                                  family: FontFamily.dmSans,
                                )),
                            Text(
                              "useremail@gmail.com",
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
                              child:
                                  Icon(Icons.person_2, color: AppColor.white),
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
              TabBar(
                  dividerColor: AppColor.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.all(8),
                  indicatorColor: AppColor.black1,
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
                  controller: tabController,
                  tabs: [
                    Center(
                        child: Text(
                      'Your Issues',
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
                  ]),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  Center(
                      child: Text(
                    "APPROVED ISSUES HERE",
                    style: Styles.boldStyle(
                      fontSize: 20,
                      color: AppColor.black1,
                      family: FontFamily.varela,
                    ),
                  )),
                  Center(
                    child: Text(
                      'PENDING ISSUES HERE',
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: AppColor.black1,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'COMPLETED ISSUES HERE',
                      style: Styles.boldStyle(
                        fontSize: 20,
                        color: AppColor.black1,
                        family: FontFamily.varela,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
