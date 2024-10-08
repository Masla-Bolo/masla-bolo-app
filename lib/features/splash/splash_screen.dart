import 'package:flutter/material.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/helpers/styles/styles.dart';
import 'package:masla_bolo_app/helpers/widgets/jumping_dots.dart';

import '../../service/app_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late SplashCubit cubit;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    cubit = getIt<SplashCubit>();
    cubit.onInit();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_animation.value * 0.1),
                child: Icon(
                  Icons.report_problem_outlined,
                  size: 100,
                  color: context.colorScheme.onPrimary,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Masla Bolo',
            style: Styles.boldStyle(
              family: FontFamily.dmSans,
              fontSize: 30,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Empowering Communities, Solving Problems',
            textAlign: TextAlign.center,
            style: Styles.boldStyle(
              family: FontFamily.varela,
              fontSize: 18,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const Spacer(),
              JumpingDots(
                numberOfDots: 3,
                color: context.colorScheme.onPrimary,
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
