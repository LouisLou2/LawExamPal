import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';

class ColorBar extends StatelessWidget {
  final double radius;
  final Color color;
  final double? height;
  final double? width;

  const ColorBar({
    Key? key,
    this.color=AppColors.darkText0,
    this.height,
    this.width,
    this.radius=20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width??MediaQuery.of(context).size.width / 5,
        maxHeight: height??5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );
  }
}