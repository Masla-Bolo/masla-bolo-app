import 'package:masla_bolo_app/features/profile/components/app_settings.dart';

class SettingsState {
  List<AppSettings> appSettings;
  SettingsState({
    required this.appSettings,
  });

  factory SettingsState.empty() =>
      SettingsState(appSettings: AppSettings.appSettings);

  copyWith({
    List<AppSettings>? appSettings,
  }) =>
      SettingsState(
        appSettings: appSettings ?? this.appSettings,
      );
}
