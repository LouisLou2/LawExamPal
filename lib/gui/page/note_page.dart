import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/info_display/show_custom_bottom_sheet.dart';
import 'package:easy_cse/gui/widget/info_display/title_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_string.dart';
import '../../constant/app_style/app_color.dart';
import '../../constant/app_style/ui_params.dart';
import '../widget/info_display/headline.dart';
import '../widget/info_display/headline2.dart';
import '../widget/info_display/short_info_tile.dart';

class NotePage extends StatefulWidget{
  const NotePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      extendBody: false,// 还没有弄清楚这个属性的作用
      // 这个drawer还没有想到要弄成什么方法
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(26.h),
        child: AppBar(
          backgroundColor: AppColors.white1,
          elevation: 0,// 去掉appbar的阴影
          surfaceTintColor: Colors.transparent,// 保证上划时，tint透明
          automaticallyImplyLeading: false,
          leading:null,
          title: Text(
            AppStrings.notes,
            style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.bold,),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:HeadLine2(
              title: AppStrings.recentNotes,
              size: 50.sp,
              iconText: AppStrings.allNotes,
            ),
          ),
          Divider(
            color: AppColors.silenceColor,
            thickness: 2.5.w,
            height: 3.h,
            indent: 20.w,
            endIndent: 20.w,
          ),
          SizedBox(height: 10.h,),
          Expanded(
            //这里的就是一些测试数据
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context,index){
                return ImageTile(
                  title: "Note $index",
                  subTitle: DateTime.now().toString(),
                  imagePath: "assets/images/avatar1.png",
                  onTap: ()=>print("Note $index"),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showCustomBottomSheet(context),
        backgroundColor: AppColors.iconBlue,
        child: const Icon(
          Icons.add,
          size: UIParams.defIconS,
          color: AppColors.white1,
        ),
      ),
    );
  }
}
