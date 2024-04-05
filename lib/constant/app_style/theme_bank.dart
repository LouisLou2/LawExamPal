import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class ThemeBank{
  static bool isDarkMode = false;
  // 各个Theme均没有启用
  static final ThemeData _themeData2 =ThemeData(
    primaryColor: AppColors.white0,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white1,
      iconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      elevation: 0,
      foregroundColor: Colors.grey[600],
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
        color: Colors.blueGrey[800],
        fontWeight: FontWeight.w800,
        fontSize: 28,
      ),
      displaySmall: TextStyle(
        color: Colors.blueGrey[800],
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      labelMedium: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: AppColors.white1,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
    colorScheme: const ColorScheme.light().copyWith(background: AppColors.white1),
  );
  static final ThemeData _themeData1 = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.white1,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 34,
        letterSpacing: 0.5,
      ),
      bodySmall: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      errorStyle: TextStyle(fontSize: 12),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      border: AppStyles.textFormFieldBorder,
      errorBorder: AppStyles.textFormFieldBorder,
      focusedBorder: AppStyles.textFormFieldBorder,
      focusedErrorBorder: AppStyles.textFormFieldBorder,
      enabledBorder: AppStyles.textFormFieldBorder,
      labelStyle: TextStyle(
        fontSize: 17,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.iconPink,
        padding: const EdgeInsets.all(4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.iconPink,
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: Colors.grey.shade200),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: AppColors.iconPink,
        disabledBackgroundColor: Colors.grey.shade300,
        minimumSize: const Size(double.infinity, 52),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );
}