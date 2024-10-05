import 'package:masla_bolo_app/features/profile/components/settings/app_settings.dart';

class SettingsState {
  List<AppSettings> appSettings;
  final bool isLoggingOut;
  SettingsState({
    this.isLoggingOut = false,
    required this.appSettings,
  });

  factory SettingsState.empty() =>
      SettingsState(appSettings: AppSettings.appSettings);

  copyWith({
    List<AppSettings>? appSettings,
    bool? isLoggingOut,
  }) =>
      SettingsState(
        isLoggingOut: isLoggingOut ?? this.isLoggingOut,
        appSettings: appSettings ?? this.appSettings,
      );
}