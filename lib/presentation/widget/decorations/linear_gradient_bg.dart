import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearGradientBg extends StatelessWidget{

  final bool? withShadow;
  final List<Color>colorGroup;
  final Widget child;
  final double? borderRadius;

  const LinearGradientBg({
    super.key,
    required this.colorGroup,
    required this.child,
    this.withShadow=false,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius!=null?BorderRadius.circular(borderRadius!):null,
        boxShadow: [
          BoxShadow(
            color: colorGroup[0].withOpacity(0.3),
            offset: const Offset(1, 2),
            blurRadius: 5,
            spreadRadius: 8,
        )],
        gradient: AppStyles.getGradientWithGroup(colorGroup.reversed.toList()),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 45.w),
        child: child,
      )
    );
  }

}