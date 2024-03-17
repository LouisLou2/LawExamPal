import 'dart:ui';

import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:flutter/material.dart';

class GuideLinePainter extends CustomPainter {

  final Color? color;
  final double? strokeWidth;
  final double width;
  final double height;
  GuideLinePainter({
    required this.width,
    required this.height,
    this.color,
    this.strokeWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.darkText2
      ..strokeWidth = strokeWidth??1.2;
    double margin = 0.02;
    double vbegin=height*margin;
    double h=height*(1-margin);
    // 这里可以自定义绘制逻辑，例如：
    // 画一个十字线，贯穿屏幕中心
    List<Offset> vPos1=[];
    List<Offset> vPos2=[];
    List<Offset> hPos1=[];
    List<Offset> hPos2=[];
    vPos1.add(Offset(-width/8, vbegin));
    vPos2.add(Offset(-width/8, h));
    vPos1.add(Offset(-width*3/8, vbegin));
    vPos2.add(Offset(-width*3/8, h));
    vPos1.add(Offset(width/8, vbegin));
    vPos2.add(Offset(width/8, h));
    vPos1.add(Offset(width*3/8, vbegin));
    vPos2.add(Offset(width*3/8, h));

    hPos1.add(Offset(-width/2, height/8));
    hPos2.add(Offset(width/2, height/8));
    hPos1.add(Offset(-width/2, height*3/8));
    hPos2.add(Offset(width/2, height*3/8));
    hPos1.add(Offset(-width/2, height*5/8));
    hPos2.add(Offset(width/2, height*5/8));
    hPos1.add(Offset(-width/2, height*7/8));
    hPos2.add(Offset(width/2, height*7/8));
    for(int i=0;i<hPos1.length;i++){
      canvas.drawLine(hPos1[i], hPos2[i], paint);
    }
    for(int i=0;i<vPos1.length;i++){
      canvas.drawLine(vPos1[i], vPos2[i], paint);
    }
    // 继续绘制更多的基准线，根据实际需要...
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class GuideLineWidget extends StatelessWidget {
  final double width;
  final double height;
  const GuideLineWidget({Key? key, required this.width, required this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GuideLinePainter(width: width, height: height),
    );
  }
}