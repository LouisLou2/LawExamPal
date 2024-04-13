import 'dart:io';

import 'package:easy_cse/constant/app_style/app_pic.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/presentation/widget/info_display/show_custom_bottom_sheet.dart';
import 'package:easy_cse/presentation/widget/info_display/title_with_image.dart';
import 'package:easy_cse/service/handler/note_handler.dart';
import 'package:easy_cse/service/provider/note/note_prov.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/util/extensions.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_rule.dart';
import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/ui_params.dart';
import '../../../constant/situation_enum.dart';
import '../../widget/empty_chat_widget.dart';
import '../../widget/info_display/headline2.dart';
import '../../widget/ui_kitbag.dart';

class NotePage extends StatefulWidget{
  const NotePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> with WidgetsBindingObserver {
  final NoteProv nprov=ProvManager.noteProv;
  final recordController = ScrollController();
  late final double screenH;
  late final double screenW;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenH = context.heightFraction();
      screenW = context.widthFraction();
      NoteHandler.showInitialNote();
      if(recordController.hasClients) {
        recordController.jumpTo(0.0);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// 适配页面切换、熄屏时倒计时混乱问题
    if (state == AppLifecycleState.resumed) {
      print("@@@@@@@@@@@@@resumed");
    } else if (state == AppLifecycleState.paused) {
      print("@@@@@@@@@@@@@paused");
    }
  }

  @override
  void dispose() {
    recordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    nprov.disposeData_list();
    super.dispose();
  }

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
        mainAxisSize: MainAxisSize.min,
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
            child: Selector<NoteProv, bool>(
              selector: (context, prov)=> prov.noteList.isEmpty,
              builder: (context, isEmpty, child)=>isEmpty?
              const EmptyWidget(text:AppStrings.emptyNoteList):
              Align(
                alignment: Alignment.topCenter,
                child: NotificationListener<ScrollEndNotification>(
                  // 不使用ScrollController::addListener,使用外层包裹的NotificationListener, ScrollEndNotification是用户停止滑动的时候触发
                  onNotification: onNotification,
                  child: Selector<NoteProv, int>(
                    selector: (context, prov)=> prov.noteList.length,
                    builder: (context, len, child)=>ListView.builder(
                      controller: recordController,
                      // key: ValueKey<int>(len), no need to use key here
                      itemBuilder: (BuildContext context, int index) {
                        final note=nprov.noteList[index];
                        return ImageTile(
                          title: note.title,
                          subTitle: FormatTool.secScaleStr(note.time),
                          imgWidget: note.imagePath==null?SvgPicture.asset(AppPic.defDocumentPic, width: 30):Image.file(File(note.imagePath!)),
                          onTap: ()=>NoteHandler.showNotePreview(index),
                        );
                      },
                      itemCount: len,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      reverse: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Selector<NoteProv, int>(
            selector: (context, prov) => prov.noteState,
            builder: (context, sta, child)=>
            sta==UIStateEnum.LOADING?UIKitBag.blue_loadingIndicator:const SizedBox(),
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
                        width: sheetw/3.5,
                        color: AppColors.iconBlue,
                        icon: CupertinoIcons.camera,
                        onTap: ()=>NoteHandler.getNote(FromType.camera),
                      ),
                      getSeleCard(
                        title: AppStrings.fromGallery,
                        height: sheeth/2.5,
                        width: sheetw/3.5,
                        color: AppColors.oilGreen,
                        icon: Icons.photo,
                        onTap: ()=>NoteHandler.getNote(FromType.gallery),
                      ),
                      getSeleCard(
                        title: AppStrings.fromFile,
                        height: sheeth/2.5,
                        width: sheetw/3.5,
                        color: AppColors.purpleBlue,
                        icon: Icons.file_open_rounded,
                        onTap: ()=>NoteHandler.getNote(FromType.file),
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
  bool onNotification(ScrollEndNotification notification){
    print("pixels:${notification.metrics.pixels},maxScrollExtent:${notification.metrics.maxScrollExtent},screenH:$screenH");
    if(notification.metrics.pixels-notification.metrics.maxScrollExtent<AppRule.loadMoreEdge) {
      NoteHandler.showMoreNote();
    }
    return false;// 返回true表示消费了这个事件，不再向上传递
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
