import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/gui/widget/buttons/colored_text_botton.dart';
import 'package:easy_cse/gui/widget/buttons/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_string.dart';

class AnswerToolBar extends StatelessWidget {
  const AnswerToolBar({Key? key}) : super(key: key);

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
            text: '错题本',
            color: AppColors.darkText0,
            size: 60,
            onTap: () {},
          ),
          IconTextButton(
            icon: Icons.print,
            text: '打印',
            color: AppColors.darkText0,
            size: 60,
            onTap: () {},
          ),
          SizedBox(width: 100.w),
          const ColorTextButton(text: AppStrings.addToWrongSet),
          SizedBox(width: 30.w),
          const ColorTextButton(text: AppStrings.snapAgain),
        ],
      ),
    );
  }
}