import 'package:masla_bolo_app/features/auth/auth_cubit.dart';
import 'package:masla_bolo_app/features/bottom_bar/bottom_bar_cubit.dart';
import 'package:masla_bolo_app/main.dart';
import 'package:nested/nested.dart';
import 'package:masla_bolo_app/features/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => AuthCubit(getIt(), getIt())),
    BlocProvider(create: (context) => SplashCubit(getIt(), getIt())..onInit()),
    BlocProvider(create: (context) => BottomBarCubit(getIt())),
  ];
}
