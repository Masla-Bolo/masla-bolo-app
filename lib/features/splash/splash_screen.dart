import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:masla_bolo_app/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = getIt<SplashCubit>();
    cubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('THIS IS SPLASH SCREEN')),
    );
  }
}
