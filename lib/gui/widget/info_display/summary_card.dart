import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/gui/widget/buttons/colored_text_botton.dart';
import 'package:easy_cse/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_style.dart';

class SummaryCard extends StatelessWidget {
  final String? title;
  final List<String>? points;
  final Color? color;
  final Widget? action;

  const SummaryCard({super.key,
    this.title,
    this.points,
    this.color,
    this.action,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 8.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        gradient: AppStyles.getLinearGradient(MaterialColorGenerator.from(color??Colors.white),reverse: true),
        boxShadow: [
          BoxShadow(
            color: (color??AppColors.silenceColor).withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(1, 2),
          )
        ],
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: AppStyles.iconTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.deepBlue,
            ),
          ),
        if (points != null) for (var point in points!)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              children: [
                Icon(Icons.star_rounded, color: AppColors.deepBlue, size: 60.sp),
                Text(
                  point,
                  style: AppStyles.iconTextStyle.copyWith(
                    fontSize: 40.sp,
                    color: AppColors.deepBlue,
                  ),
                ),
              ],
            ),
          ),
        if(action!=null)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            action!,
          ],
        )
        ],
      ),
    );
  }
}