import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/profile/components/settings_state.dart';

import 'settings_navigator.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsNavigator navigator;
  SettingsCubit(this.navigator) : super(SettingsState.empty());
  pop() {
    navigator.pop();
  }
}
