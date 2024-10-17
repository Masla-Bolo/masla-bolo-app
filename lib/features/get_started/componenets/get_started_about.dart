import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/get_started/componenets/get_started_header.dart';
import 'package:masla_bolo_app/features/get_started/get_started_cubit.dart';
import 'package:masla_bolo_app/features/get_started/get_started_state.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';

import '../../../di/service_locator.dart';
import 'info_card.dart';

class GetStartedAbout extends StatefulWidget {
  const GetStartedAbout({super.key});

  @override
  State<GetStartedAbout> createState() => _GetStartedAboutState();
}

class _GetStartedAboutState extends State<GetStartedAbout> {
  final cubit = getIt<GetStartedCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStartedCubit, GetStartedState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      15.verticalSpace,
                      GetStartedHeader(
                        hideBack: true,
                        onNextTap: () {
                          cubit.goToNextPage();
                        },
                      ),
                      30.verticalSpace,
                      Center(
                        child: Icon(
                          Icons.help_outline_sharp,
                          size: 100.w,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: Text(
                          "Welcome to Masla Bolo!",
                          style: Styles.boldStyle(
                            fontSize: 30,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.dmSans,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: Text(
                          "Report local issues & drive real change.",
                          style: Styles.semiBoldStyle(
                            fontSize: 18.sp,
                            color: context.colorScheme.onPrimary,
                            family: FontFamily.varela,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      30.verticalSpace,
                      const InfoCard(
                        title: "🚧 Why Masla Bolo?",
                        subTitle:
                            "Easily report infrastructure issues like potholes, broken lights, and illegal dumping. Help us improve your city!",
                      ),
                      20.verticalSpace,
                      const InfoCard(
                        title: "🎯 Our Mission",
                        subTitle:
                            "We connect you directly with city officials to fix problems faster. No more delays, just results.",
                      ),
                      20.verticalSpace,
                      const InfoCard(
                        title: "🌍 Make a Difference",
                        subTitle:
                            "Together, we can create a cleaner, safer city. Your reports matter!",
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
