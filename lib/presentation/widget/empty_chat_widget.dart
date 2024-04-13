import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

import '../../constant/app_style/app_color.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;
  const EmptyWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text ?? '',
        style: AppStyles.iconTextStyle.copyWith(
          color: AppColors.darkText1,
        ),
      ),
    );
  }
}