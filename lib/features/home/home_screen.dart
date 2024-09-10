import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/home_body.dart';
import 'package:masla_bolo_app/features/home/components/home_filter_drawer.dart';
import 'package:masla_bolo_app/features/home/components/home_search.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/stores/user_store.dart';
import '../../helpers/styles/app_colors.dart';
import '../../helpers/widgets/header.dart';
import '../../main.dart';

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
    homeCubit.navigation.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: HomeFilterDrawer(cubit: homeCubit),
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
                          onTap: () => homeCubit.navigation.goToNotification(),
                          child: const Icon(
                            Icons.notifications_none,
                            color: AppColor.grey,
                          ),
                        ),
                        10.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: AppColor.grey,
                          ),
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
