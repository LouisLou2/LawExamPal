import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';

Widget getJumpButton(BuildContext context,{required bool up,VoidCallback? func}){
  return FloatingActionButton(
    onPressed: func,
    mini: true,
    backgroundColor: AppColors.silentBlue.withOpacity(0.8),
    child: Icon(
      up?Icons.arrow_upward:Icons.arrow_downward,
      color: AppColors.white1,
    ),
  );
}