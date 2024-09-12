import 'package:device_preview/device_preview.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';
import 'package:masla_bolo_app/navigation/app_navigation.dart';
import 'package:masla_bolo_app/service/app_service.dart';

import 'helpers/styles/app_theme.dart';
import 'navigation/route_generator.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeMode = await AdaptiveTheme.getThemeMode();
  await AppService.initialize(getIt);
  runApp(MaslaBolo(themMode: themeMode));
}

class MaslaBolo extends StatelessWidget {
  final AdaptiveThemeMode? themMode;
  const MaslaBolo({super.key, required this.themMode});
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        enabled: false,
        builder: (context) {
          return AdaptiveTheme(
            light: AppTheme.theme(),
            initial: themMode ?? AdaptiveThemeMode.dark,
            dark: AppTheme.theme(dark: true),
            builder: (light, dark) {
              return GlobalLoaderOverlay(
                overlayColor: Colors.transparent,
                child: ScreenUtilInit(
                    designSize: Size(context.screenWidth, context.screenHeight),
                    builder: (context, _) {
                      SystemChrome.setSystemUIOverlayStyle(
                        SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                          systemNavigationBarColor:
                              Theme.of(context).colorScheme.surface,
                        ),
                      );
                      return MaterialApp(
                        theme: AppTheme.theme(),
                        darkTheme: AppTheme.theme(dark: true),
                        themeMode: ThemeMode.light,
                        debugShowCheckedModeBanner: false,
                        navigatorKey: AppNavigation.navigatorKey,
                        onGenerateRoute: generateRoute,
                      );
                    }),
              );
            },
          );
        });
  }
}
