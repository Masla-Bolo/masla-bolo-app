import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/home/components/home_body.dart';
import 'package:masla_bolo_app/features/home/components/home_filter_drawer.dart';
import 'package:masla_bolo_app/features/home/components/home_search.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_cubit.dart';
import 'package:masla_bolo_app/features/home/components/issue/issue_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../helpers/widgets/header.dart';
import '../../service/app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cubit});
  final IssueCubit cubit;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IssueCubit homeCubit;

  @override
  void initState() {
    super.initState();
    homeCubit = widget.cubit;
    if (!homeCubit.state.isLoaded) {
      homeCubit.getIssues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeFilterDrawer(cubit: homeCubit),
      onEndDrawerChanged: (result) {
        getIt<BottomBarCubit>().toggleVisibility();
      },
      body: SafeArea(
        child: BlocBuilder<IssueCubit, IssueState>(
            bloc: homeCubit,
            builder: (context, state) {
              return Column(
                children: [
                  10.verticalSpace,
                  // header
                  Header(
                    hideBackIcon: true,
                    title: "Masla Bolo",
                    suffix: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Image.asset(AppImages.filter, height: 30),
                    ),
                  ),
                  20.verticalSpace,
                  //search
                  HomeSearch(cubit: homeCubit),
                  10.verticalSpace,
                  //list of issues
                  HomeBody(cubit: homeCubit),
                ],
              );
            }),
      ),
    );
  }
}
