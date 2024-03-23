import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class ColorTextButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onPressed;

  const ColorTextButton({super.key, required this.text, this.color, this.onPressed, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: AppStyles.defButtonStyle(
        color:color??AppColors.purpleBlue,
        height:height??50,
        width:width??100,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppStyles.bodySmall,
      ),
    );
  }
}