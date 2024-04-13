import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class TextSection extends StatelessWidget {
  final String title;
  final String content;

  const TextSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child:ListTile(
        tileColor: AppColors.white0,
        title: Padding(
          padding: EdgeInsets.only(bottom:10.h),
          child: Text(
            title,
            style: AppStyles.iconTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkText0,
            ),
          ),
        ),
        subtitle: Text(
          content,
          style: AppStyles.bodySmall.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}