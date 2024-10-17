import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:masla_bolo_app/helpers/extensions.dart';

import '../helpers/styles/app_theme.dart';
import '../navigation/app_navigation.dart';
import '../navigation/route_generator.dart';

class MaslaBolo extends StatelessWidget {
  const MaslaBolo({super.key});
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        enabled: false,
        builder: (context) {
          return AdaptiveTheme(
            light: AppTheme.theme(),
            initial: AdaptiveThemeMode.dark,
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
                          systemNavigationBarColor: context.colorScheme.surface,
                        ),
                      );
                      return MaterialApp(
                        theme: light,
                        darkTheme: dark,
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
