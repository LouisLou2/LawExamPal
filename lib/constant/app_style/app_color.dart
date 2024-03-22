import 'dart:ui';

import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

class AppColors{
  const AppColors._();
  static const Color white0=Colors.white; // 完全白色
  static const Color white1 = Color(0xfff6f6f5); // 白色带有一点灰色，稍显温和
  static const Color white2 = Color(0xffe5e5e5); // 白色带有更多灰色
  static const Color darkText0=Colors.black;
  static const Color darkText1=Color(0xff52565e);
  static const MaterialColor iconPink=Colors.pink;
  static Color lightPurple=Colors.purple[50]!;
  static const Color normalPurple = Colors.purple;
  static const Color iconBlue = Color(0xff0099e5);
  static const Color silenceColor = Colors.grey;
  static const Color lightBorderColor = Colors.black12;
  static const Color linkBlue=Color(0xff17c0eb);
  static const Color darkText2=Color(0xff3d3d3d);
  static const Color greyText1=Color(0xff718093);
  static const Color orange1=Color(0xfffd9644);
  static const Color orange2=Color(0xfff69653);
  static const Color yellow1=Color(0xfff9ca24);
  static const Color oilGreen=Color(0xff84bd00);
  static const MaterialColor basicGreen=Colors.green;


  static const Color freshBlue=Color(0xff34e7e4);
  static const Color jadeBlue=Color(0xff00d8d6);
  static const Color megaBlue=Color(0xff4bcffa);
  static const Color discoBallBlue=Color(0xff0fbcf9);
  static const Color purpleBlue=Color(0xff4169E1);
  static const Color silentBlue=Color(0xff2E86c1);
  static const List<Color> freshBlueGroup=[freshBlue,jadeBlue,discoBallBlue];


  //static const accentColor = Color(0xff0984e3); // 黄色
  static const Color black0 = Colors.black; // 完全黑色
  static const Color black1 = Color(0xff2d3436);


  static const Color blue1 = Color(0xff3498db);
  static const Color blue2 = Color(0xff2E86c1);
  static const Color blue3 = Color(0xff2874a6);
  static Color get primaryColor => Colors.pink[400]!;
  static MaterialColor get primarySwatch => Colors.pink;
  static Color getAccentColor(bool dark)=>dark?primaryColor:Colors.grey[600]!;
  static Color getBgColor(bool dark) => dark ? Colors.black : Colors.grey[50]!;
  static const List<Color> defaultGradient = [
    blue1,blue2,blue3
  ];
}