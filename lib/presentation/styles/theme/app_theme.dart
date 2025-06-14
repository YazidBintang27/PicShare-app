import 'package:flutter/material.dart';
import 'package:picshare_app/presentation/styles/typography/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        colorScheme: ColorScheme.light(
            primary: const Color(0xFF2961FD),
            onPrimary: const Color(0xFFFFFFFF),
            tertiary: const Color(0xFF262626)),
        brightness: Brightness.light,
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent, 
        textTheme: _textTheme);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        colorScheme: ColorScheme.dark(
            primary: const Color(0xFF2961FD),
            onPrimary: const Color(0xFF262626),
            tertiary: const Color(0xFFFFFFFF)),
        brightness: Brightness.dark,
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent, 
        textTheme: _textTheme);
  }

  static TextTheme get _textTheme {
    return TextTheme(
        displaySmall: AppTypography.displaySmall,
        headlineSmall: AppTypography.headlineSmall,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLargeRegular);
  }
}