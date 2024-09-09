import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masla_bolo_app/features/home/components/home_body.dart';
import 'package:masla_bolo_app/features/home/components/home_filter.dart';
import 'package:masla_bolo_app/features/home/components/home_header.dart';
import 'package:masla_bolo_app/features/home/home_cubit.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/stores/user_store.dart';
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
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
            bloc: homeCubit,
            builder: (context, state) {
              return Column(
                children: [
                  20.verticalSpace,
                  // header
                  HomeHeader(cubit: homeCubit),
                  20.verticalSpace,
                  //filters
                  HomeFilter(cubit: homeCubit),
                  //issues post
                  HomeBody(cubit: homeCubit),
                ],
              );
            }),
      ),
    );
  }
}