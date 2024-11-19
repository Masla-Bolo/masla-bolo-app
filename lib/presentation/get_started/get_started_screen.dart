import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'get_started_state.dart';

import '../../di/service_locator.dart';
import '../../helpers/helpers.dart';
import 'get_started_cubit.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  static final cubit = getIt<GetStartedCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStartedCubit, GetStartedState>(
      bloc: cubit,
      builder: (context, state) {
        return PopScope(
          canPop: state.canPop,
          onPopInvokedWithResult: (result, _) async {
            if (await showConfirmationDialog('Do you want to exit the app?') &&
                context.mounted) {
              cubit.exitApp();
            }
          },
          child: PageView.builder(
            controller: state.pageController,
            itemCount: state.pages.length,
            onPageChanged: cubit.updateIndex,
            itemBuilder: (context, index) {
              return state.pages[index];
            },
          ),
        );
      },
    );
  }
}
