import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:tokyo/features/theme/color_theme.dart';

class TokyoTheme {
  static ThemeData lightColorTheme() {
    final colorTheme = GetIt.I.get<ColorTheme>();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 249, 1),
      primaryColor: colorTheme.verdeEscuro,
      primaryColorLight: colorTheme.verdeClaro,
      primaryColorDark: colorTheme.verdeEscuro,

      fontFamily: GoogleFonts.poppins().fontFamily,

      textTheme: _buildTextTheme(Colors.black),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorTheme.verdeEscuro,
        selectionColor: colorTheme.verdeClaro.withOpacity(0.3),
        selectionHandleColor: colorTheme.verdeClaro,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: colorTheme.verdeEscuro,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorTheme.verdeEscuro,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorTheme.verdeEscuro,
          side: BorderSide(color: colorTheme.verdeEscuro),
        ),
      ),

      colorScheme: ColorScheme.light(
        primary: colorTheme.verdeEscuro,
        secondary: colorTheme.verdeClaro,
        tertiary: colorTheme.dourado,
      ),
    );
  }

  static ThemeData darkColorTheme() {
    final colorTheme = GetIt.I.get<ColorTheme>();

    return ThemeData(
      cardTheme: CardThemeData(color: const Color(0xFF2B2A3A)),

      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1f2428), // cinza escuro/preto

      primaryColor: colorTheme.verdeClaro, // tons mais claros no dark
      primaryColorLight: colorTheme.verdeClaro,
      primaryColorDark: colorTheme.verdeEscuro,

      fontFamily: GoogleFonts.poppins().fontFamily,

      textTheme: _buildTextTheme(Colors.white),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorTheme.verdeClaro,
        selectionColor: colorTheme.verdeClaro.withOpacity(0.5),
        selectionHandleColor: colorTheme.verdeClaro,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: colorTheme.verdeEscuro,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorTheme.verdeClaro,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorTheme.verdeClaro,
          side: BorderSide(color: colorTheme.verdeClaro),
        ),
      ),

      colorScheme: ColorScheme.dark(
        primary: colorTheme.verdeClaro,
        secondary: colorTheme.verdeEscuro,
        tertiary: colorTheme.dourado,
        background: const Color(0xFF3D4849),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      bodyLarge: TextStyle(color: color),
      bodyMedium: TextStyle(color: color),
      bodySmall: TextStyle(color: color),
      displayLarge: TextStyle(color: color),
      displayMedium: TextStyle(color: color),
      displaySmall: TextStyle(color: color),
      headlineLarge: TextStyle(color: color),
      headlineMedium: TextStyle(color: color),
      headlineSmall: TextStyle(color: color),
      titleLarge: TextStyle(color: color),
      titleMedium: TextStyle(color: color),
      titleSmall: TextStyle(color: color),
      labelLarge: TextStyle(color: color),
      labelMedium: TextStyle(color: color),
      labelSmall: TextStyle(color: color),
    );
  }
}
