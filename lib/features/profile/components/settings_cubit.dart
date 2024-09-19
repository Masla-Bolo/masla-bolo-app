import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:masla_bolo_app/features/profile/components/settings_state.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import 'settings_navigator.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsNavigator navigator;
  final LocalStorageRepository localStorageRepository;
  SettingsCubit(this.navigator, this.localStorageRepository)
      : super(SettingsState.empty());
  void popAll() {
    localStorageRepository.deleteValue(tokenKey);
    navigator.popAll();
  }

  void pop() {
    navigator.pop();
  }
}
