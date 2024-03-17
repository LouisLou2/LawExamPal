import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/app_style/app_color.dart';
class AppColor {
  static const BG_COLOR = Color(0xFFf2f2f5);
  static const PRIMARY = Color(0xFF4764cd);
  static const SECONDARY = Color(0xFFeff2fa);

  static const TEXT_COLOR = Color(0xFF3a3f49);
  static const BODY_COLOR = Color(0xFF4764cd);
  static const WHITE = Color(0xFFFFFFFF);
  static const BLACK = Color(0xFF000000);
}
class ThemeBank{
  // 深浅两个主题先用此这两个吧
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,// 使用Material3
    visualDensity: VisualDensity.adaptivePlatformDensity,// 适配平台
    brightness: Brightness.light,// 亮度

    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.getFont(
          'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.black0,
      ),
      actionsIconTheme: const IconThemeData(
          color: AppColor.PRIMARY
      ),
      iconTheme: const IconThemeData(
          color :AppColor.PRIMARY
      ),
      backgroundColor: AppColors.white1,
    ),
    cardTheme:  const CardTheme(
        color: AppColor.WHITE
    ),
    primaryColor: AppColor.PRIMARY,
    highlightColor: AppColor.PRIMARY,
    scaffoldBackgroundColor: AppColor.BG_COLOR,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.getFont(
          'Outfit',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      displayMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      displaySmall: GoogleFonts.getFont(
          'Outfit',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      titleLarge: GoogleFonts.getFont(
          'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      titleMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      titleSmall: GoogleFonts.getFont(
          'Outfit',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
      ),
      bodyLarge:GoogleFonts.getFont(
          'Outfit',
          fontSize: 16,
          color: AppColor.BLACK
      ),
      bodyMedium: GoogleFonts.getFont(
          'Outfit',
          fontSize: 14,
          color: AppColor.BLACK
      ),        bodySmall: GoogleFonts.getFont(
        'Outfit',
        fontSize: 12,
        color: AppColor.BLACK.withOpacity(0.4)
    ),
    ),
    iconTheme: const IconThemeData(color: AppColor.PRIMARY),
    textButtonTheme: TextButtonThemeData(
        style:  ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColor.BODY_COLOR),
            foregroundColor: MaterialStateProperty.all<Color>(AppColor.WHITE),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))
                )
            )
        )
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      selectedColor: AppColor.BODY_COLOR,
      fillColor: AppColor.BODY_COLOR.withOpacity(0.1),
      textStyle: const TextStyle(color: AppColor.WHITE),
      selectedBorderColor: AppColor.BODY_COLOR,
      borderRadius: BorderRadius.circular(8.0),
    ),
    colorScheme:  ColorScheme.fromSwatch().copyWith(
      primary: AppColor.PRIMARY,
      onPrimary: AppColor.PRIMARY,
      secondary: AppColor.SECONDARY,
      onSecondary: AppColor.SECONDARY,
      surface: AppColor.BG_COLOR,
      onSurface: AppColor.BG_COLOR,
      error: Colors.red,
      onError: Colors.red,
      background: AppColor.BG_COLOR,
      onBackground: AppColor.BG_COLOR,
      brightness: Brightness.light,
    ),
  );
  static final ThemeData _darkTheme = ThemeData.dark(useMaterial3: true);
  // getter
  static ThemeData lightTheme() => _lightTheme;
  static ThemeData darkTheme() => _darkTheme;
  // method
  static ThemeData getTheme(bool isDarkMode){
    return isDarkMode ? _darkTheme : _lightTheme;
  }
}