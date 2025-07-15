import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

import 'package:tokyo/core/utils/tokyo_utils.dart';
import 'package:tokyo/features/theme/color_theme.dart';
import 'package:tokyo/features/theme/theme_controller.dart';
import 'package:tokyo/features/theme/tokyo_theme.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registrar serviços existentes
  getIt.registerSingleton<GlobalKey<ScaffoldMessengerState>>(
    GlobalKey<ScaffoldMessengerState>(),
  );
  getIt.registerSingleton<LocalAuthentication>(LocalAuthentication());
  getIt.registerSingleton<ThemeController>(ThemeController());
  getIt.registerSingleton<TokyoTheme>(TokyoTheme());
  getIt.registerSingleton<TokyoUtils>(TokyoUtils());
  getIt.registerSingleton<ColorTheme>(ColorTheme());
}
