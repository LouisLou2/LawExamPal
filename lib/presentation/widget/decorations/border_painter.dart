import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white1 // 边框颜色
      ..style = PaintingStyle.stroke // 画边框
      ..strokeWidth = 3.0; // 边框宽度

    // 定义圆角矩形的大小和边框的圆角
    final RRect borderRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width*0.5, size.height),
      const Radius.circular(10.0), // 边框的圆角
    );
    // 绘制圆角矩形边框
    canvas.drawRRect(borderRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 如果绘画逻辑有变，这里应返回true
    return false;
  }
}

// 使用自定义Painter绘制圆角边框
class BorderBox extends StatelessWidget {
  const BorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20.0, 10), // 指定绘制区域的大小
      painter: BorderPainter(),
    );
  }
}