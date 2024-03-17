import 'dart:ui';

import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';


class DecoratedAvatar extends StatelessWidget {
  final String image;
  final double radius;
  final double? borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;

  const DecoratedAvatar({super.key,
    required this.image,
    required this.radius,
    this.borderWidth,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2), // 边框到CircleAvatar的距离，可以根据需要设置
        decoration: BoxDecoration(
          shape: BoxShape.circle, // 装饰器形状设为圆形
          border: Border.all(
            color: borderColor??AppColors.iconPink, // 边框颜色
            width: borderWidth??UIParams.defAvatarBorderW, // 边框宽度
          ),
        ),
        // 先用一个静态头像吧，真正使用时，图像可能还需要压缩后显示，有方便的库
        child: CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(image),
        ),
      ),
    );
  }
}