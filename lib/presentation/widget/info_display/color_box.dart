import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class ColorBox extends StatelessWidget {
  final MaterialColor color;
  final IconData icon;
  final String title;
  final double size;
  final String? spec;
  final bool? isSmall;
  final VoidCallback? onTap;
  const ColorBox({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    this.spec,
    this.isSmall=false, required this.size,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      padding: EdgeInsets.all(size*0.1),
      decoration: BoxDecoration(
        color: color[400],
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: UIParams.apparentShadowBlurR,
            spreadRadius: 4,
            offset: const Offset(2, 6),
          )
        ],
        gradient: AppStyles.getDarkLinearGradient(color),
        borderRadius: BorderRadius.circular(UIParams.bigBorderR),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,//注意，gestureDetector的范围是内部更小的，这里设置点击区域为整个组件的范围，即使子组件的透明区域也会被视为可点击的区域。
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size*0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size*0.55,),
              Align(
                alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
                child: Icon(
                  icon,
                  size: isSmall! ? 100.w : 200.w,
                  color: AppColors.white0,
                ),
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: AppColors.white0,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (spec != null)
                Padding(
                  padding: EdgeInsets.only(top: size*0.08),
                  child: Text(
                    spec!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(height: size*0.1,),
            ],
          ),
        ),
      )
    );
  }
}