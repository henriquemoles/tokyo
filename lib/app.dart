import 'package:tokyo/features/theme/theme_controller.dart';
import 'package:tokyo/routes.dart';
import 'package:tokyo/features/theme/tokyo_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  App({super.key});
  final themeController = GetIt.I.get<ThemeController>();

  final scaffoldMessengerKey = GetIt.I<GlobalKey<ScaffoldMessengerState>>();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController.themeMode,
      builder: (context, currentThemeMode, _) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Tokyo test app',
          theme: TokyoTheme.lightColorTheme(),
          darkTheme: TokyoTheme.darkColorTheme(),
          themeMode: currentThemeMode,
          routerConfig: tokyoRouter,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
        );
      },
    );
  }
}
