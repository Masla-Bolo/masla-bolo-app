import 'package:masla_bolo_app/features/home/home_navigator.dart';
import 'package:masla_bolo_app/features/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigation;
  HomeCubit(this.navigation) : super(HomeState.empty());
}
