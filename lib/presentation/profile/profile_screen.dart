import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/presentation/profile/components/official_profile/official_profile.dart';
import '../../helpers/widgets/rounded_image.dart';
import 'components/user_profile/user_profile.dart';
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

class _ProfileScreenState extends State<ProfileScreen> {
  final cubit = getIt<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getUser();
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
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  state.user.role == "official"
                      ? const OfficialProfile()
                      : const UserProfile(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
