import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/get_started/get_started_state.dart';
import 'package:masla_bolo_app/main.dart';

import 'get_started_cubit.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late GetStartedCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<GetStartedCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStartedCubit, GetStartedState>(
      bloc: cubit,
      builder: (context, state) {
        return PageView.builder(
          controller: state.pageController,
          itemCount: state.pages.length,
          onPageChanged: cubit.updateIndex,
          itemBuilder: (context, index) {
            return state.pages[index];
          },
        );
      },
    );
  }
}
