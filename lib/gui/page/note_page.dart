import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/info_display/show_custom_bottom_sheet.dart';
import 'package:easy_cse/gui/widget/info_display/title_with_image.dart';
import 'package:easy_cse/service/file_manager/image_manger.dart';
import 'package:easy_cse/util/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_string.dart';
import '../../constant/app_style/app_color.dart';
import '../../constant/app_style/ui_params.dart';
import '../widget/info_display/headline2.dart';

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
            thickness: 0.5.h,
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
        onPressed: () {
          double sheeth=context.heightFraction(fraction: 0.28);
          double sheetw=context.widthFraction();
          showCustomBottomSheet(
              context,
              height: sheeth,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    child: HeadLine2(
                      title: AppStrings.addNote,
                      size: 50.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getSeleCard(
                        title: AppStrings.fromCamera,
                        height: sheeth/2.5,
                        width: sheetw/2.5,
                        color: AppColors.iconBlue,
                        icon: CupertinoIcons.camera,
                        onTap: ()=>ImageManager.editImg(false),
                      ),
                      getSeleCard(
                        title: AppStrings.fromGallery,
                        height: sheeth/2.5,
                        width: sheetw/2.5,
                        color: AppColors.oilGreen,
                        icon: Icons.photo,
                        onTap: ()=>ImageManager.editImg(true),
                      ),
                    ],
                  ),
                ],
              )
          );
        },
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

Widget getSeleCard({String? title, required double height,required double width,required Color color,required IconData icon,VoidCallback? onTap}) {
  return Card(
    color: color,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: width/4,
                color: AppColors.white0,
              ),
              SizedBox(height: 1.h),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 38.sp,
                  color: AppColors.white0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
