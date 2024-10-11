import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/jumping_dots.dart';

import '../../service/app_service.dart';
import 'splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashCubit cubit;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    cubit = getIt<SplashCubit>();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        cubit.onInit();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashState>(
        bloc: cubit,
        builder: (context, state) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.colorScheme.primary.withOpacity(0.8),
                    context.colorScheme.onSecondary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Masla Bolo',
                            style: Styles.boldStyle(
                              family: FontFamily.dmSans,
                              fontSize: 36,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Empowering Communities,\nSolving Problems',
                            textAlign: TextAlign.center,
                            style: Styles.boldStyle(
                              family: FontFamily.varela,
                              fontSize: 18,
                              color: context.colorScheme.onPrimary
                                  .withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (state.isLoaded)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        JumpingDots(
                          numberOfDots: 3,
                          color: context.colorScheme.onPrimary,
                        ),
                      ],
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
