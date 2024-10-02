import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/features/home/components/home_body.dart';
import 'package:masla_bolo_app/features/home/components/home_filter_drawer.dart';
import 'package:masla_bolo_app/features/home/components/home_search.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/helpers/styles/app_images.dart';

import '../../domain/stores/user_store.dart';
import '../../helpers/widgets/header.dart';
import '../../service/app_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit homeCubit;
  final user = getIt<UserStore>().state;

  @override
  void initState() {
    super.initState();
    homeCubit = widget.cubit;
    homeCubit.getIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeFilterDrawer(cubit: homeCubit),
      onEndDrawerChanged: (result) {
        getIt<BottomBarCubit>().toggleVisibility();
      },
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
            bloc: homeCubit,
            builder: (context, state) {
              return Column(
                children: [
                  10.verticalSpace,
                  // header
                  Header(
                    hideBackIcon: true,
                    title: "Masla Bolo",
                    suffix: Row(
                      children: [
                        GestureDetector(
                          onTap: () => homeCubit.goToNotification(),
                          child: Image.asset(AppImages.bell, height: 20),
                        ),
                        15.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Image.asset(AppImages.filter, height: 30),
                        ),
                      ],
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
