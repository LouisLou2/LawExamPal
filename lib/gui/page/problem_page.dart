import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../constant/app_style/app_style.dart';

class ProblemDetailPage extends StatefulWidget{
  final int index;
  const ProblemDetailPage({Key? key,required this.index}):super(key:key);
  @override
  State<ProblemDetailPage> createState()=>_ProblemDetailPageState();
}
class _ProblemDetailPageState extends State<ProblemDetailPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: AppColors.white1,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 5.h),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShadBadge.secondary(
                  text: Text('单选题'),
                  backgroundColor: AppColors.purpleBlue,
                  hoverBackgroundColor: AppColors.purpleBlue,
                ),
              ],
            ),
          ),
          SelectableText(
            '问题描述',
            style: AppStyles.bodySmall.copyWith(color: AppColors.darkText0),
          ),
        ],
      ),
    );
  }
}