import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_string.dart';
import 'buttons/colored_text_botton.dart';
import 'buttons/icon_text_button.dart';
// !!!!注意这个只是将页面分出的类，不是可以复用的组件！！！！！！
class AnswerToolBar extends StatelessWidget {
  const AnswerToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      color: AppColors.white0,
      child:Row(
        children: [
          const SizedBox(width: 10),
          IconTextButton(
            icon: Icons.book,
            text: AppStrings.wrongSet,
            color: AppColors.darkText0,
            size: 60,
            onTap: () {},
          ),
          IconTextButton(
            icon: Icons.print,
            text: AppStrings.print,
            color: AppColors.darkText0,
            size: 60,
            onTap: () {},
          ),
          SizedBox(width: 100.w),
          const ColorTextButton(text: AppStrings.addToWrongSet),
          SizedBox(width: 30.w),
          ColorTextButton(
            text: AppStrings.snapAgain,
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}