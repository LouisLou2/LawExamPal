import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinearGradientBg extends StatelessWidget{

  final bool? withShadow;
  final List<Color>colorGroup;
  final Widget child;

  const LinearGradientBg({
    super.key,
    required this.colorGroup,
    required this.child,
    this.withShadow=false,
  });
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.freshBlueGroup[0].withOpacity(0.3),
            offset: const Offset(1, 2),
            blurRadius: 5,
            spreadRadius: 8,
        )],
        gradient: AppStyles.getGradientWithGroup(AppColors.freshBlueGroup.reversed.toList()),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 45.w),
        child: child,
      )
    );
  }

}