import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const String defFontFamily = "Roboto";
  static const iconTextStyle = TextStyle(
    fontFamily: defFontFamily,
    fontSize: 20,
    letterSpacing: 0.5,
  );
  static const TextStyle titleLarge = TextStyle(
    fontFamily: defFontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 34,
    letterSpacing: 0.5,
  );
  static const titleMedium = TextStyle(
    fontFamily: defFontFamily,
    fontSize: 25,
    letterSpacing: 0.5,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: defFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.white0,
    letterSpacing: 0.6,
  );
  static TextStyle textBtnOrLinkStyle =const TextStyle(
    fontFamily: defFontFamily,
    color: AppColors.silentBlue,
    fontSize: 20,
    letterSpacing: 0.5,
  );
  static const textFormFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: AppColors.lightBorderColor, width: 1.6),
  );

  static LinearGradient getLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [color[400]!, color[200]!, color[100]!,],
      stops: const [0.4, 0.7, 0.9,],
    );
  }

  static LinearGradient getDarkLinearGradient(MaterialColor color) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [color[400]!, color[300]!, color[200]!,],
      stops: const [0.4, 0.6, 1,],
    );
  }

  static LinearGradient getGradientWithGroup(List<Color>colorGroup){
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: colorGroup,
      stops: const [0.4, 0.7, 0.9,],
    );
  }

  static BoxDecoration getCircledBoxDecor(MaterialColor color){
    return BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: UIParams.defShadowBlurR,
          offset: const Offset(2, 2)
        ),
      ],
      gradient: getLinearGradient(color),
    );
  }
}