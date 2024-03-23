import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.emptyChat,
        style: AppStyles.iconTextStyle.copyWith(
          color: AppColors.darkText1,
        ),
      ),
    );
  }
}