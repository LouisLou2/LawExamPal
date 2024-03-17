import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';

import '../../constant/app_style/app_style.dart';

class CircleGradientIcon extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final MaterialColor color;
  final Color? iconColor;
  final double size;
  final double? iconSize;
  const CircleGradientIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.color,
    this.iconColor,
    this.iconSize,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: AppStyles.getCircledBoxDecor(color),
        child: Icon(icon,
          color: Colors.white,
          size: iconSize ?? UIParams.defIconS,
        ),
      ),
    );
  }
}
