import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/profile/components/settings/settings_state.dart';
import 'package:masla_bolo_app/helpers/strings.dart';

import '../../../../data/local_storage/local_storage_repository.dart';
import 'settings_navigator.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsNavigator navigator;
  final LocalStorageRepository localStorageRepository;
  SettingsCubit(this.navigator, this.localStorageRepository)
      : super(SettingsState.empty());
  void popAll() {
    emit(state.copyWith(isLoggingOut: true));
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              localStorageRepository.deleteValue(tokenKey),
              navigator.popAll(),
              emit(state.copyWith(isLoggingOut: false)),
            });
  }

  void pop() {
    navigator.pop();
  }
}
