import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/profile/profile_navigator.dart';
import 'package:masla_bolo_app/features/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileNavigator navigation;
  ProfileCubit(this.navigation) : super(ProfileState.empty());

  goToSettings() {
    navigation.goToSettings();
  }
}
