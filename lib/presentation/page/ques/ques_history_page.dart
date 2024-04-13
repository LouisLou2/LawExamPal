import "dart:io";

import "package:easy_cse/constant/app_rule.dart";
import "package:easy_cse/constant/app_string.dart";
import "package:easy_cse/constant/app_style/app_style.dart";
import "package:easy_cse/presentation/widget/buttons/jump_button.dart";
import "package:easy_cse/presentation/widget/config/floating_location.dart";
import "package:easy_cse/presentation/widget/ui_kitbag.dart";
import "package:easy_cse/service/handler/history_handler.dart";
import "package:easy_cse/service/provider/prov_manager.dart";
import "package:easy_cse/service/provider/ques/ques_history_prov.dart";
import "package:easy_cse/util/extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:image_card/image_card.dart";
import "package:provider/provider.dart";

import "../../../constant/app_style/app_color.dart";
import "../../../constant/situation_enum.dart";
import "../../../util/format_tool.dart";
import "../../widget/empty_chat_widget.dart";

Widget _title({required String title}) {
  return Text(
    title,
    style: AppStyles.bodySmall,
  );
}

Widget _tag(String tag, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.silentGreen),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        tag,
        style: const TextStyle(color: AppColors.white0),
      ),
    ),
  );
}

class QuesHistoryPage extends StatefulWidget {
  const QuesHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() =>_QuesHistoryPageState();
}

class _QuesHistoryPageState extends State<QuesHistoryPage>{

  final recordController = ScrollController();
  late final double screenH;
  late final double screenW;
  final QuesHistoryProv qprov = ProvManager.quesHistoryProv;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenH = context.heightFraction();
      screenW = context.widthFraction();
      HistoryHandler.showQuesSearchHistory();
      if(recordController.hasClients) {
        recordController.jumpTo(0.0);
      }
    });
  }
  @override
  void dispose(){
    recordController.dispose();
    qprov.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.history,
          style:AppStyles.iconTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: AppColors.discoBallBlue,
        centerTitle: true,
        toolbarHeight: 50,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Selector<QuesHistoryProv, bool>(
              selector: (context, prov)=> prov.quesHistoryList.isEmpty,
              builder: (context, isEmpty, child)=>isEmpty?
              const EmptyWidget(text:AppStrings.noHistory):
              Align(
                alignment: Alignment.topCenter,
                child: NotificationListener<ScrollEndNotification>(
                  // 不使用ScrollController::addListener,使用外层包裹的NotificationListener, ScrollEndNotification是用户停止滑动的时候触发
                  onNotification: onNotification,
                  child: Selector<QuesHistoryProv, int>(
                    selector: (context, prov)=> prov.quesHistoryList.length,
                    builder: (context, len, child)=>ListView.builder(
                      controller: recordController,
                      // key: ValueKey<int>(len), no need to use key here
                      itemBuilder: (BuildContext context, int index) {
                        final history=qprov.quesHistoryList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 40.w),
                          child: TransparentImageCard(
                            width: 900.w,
                            imageProvider: FileImage(File(history.imgPath)),
                            tags: [ _tag(AppStrings.chosen, () {}), ],
                            title: _title(title:FormatTool.secScaleStr(history.time)),
                          ),
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
          Selector<QuesHistoryProv, bool>(
            selector: (context, prov) => prov.showMoreButton,
            builder: (context, more, child)=> more?const OutlinedButton(
                onPressed: HistoryHandler.showQuesSearchHistory_More,
                child: Text(
                  AppStrings.seeMore,
                  style: AppStyles.bodySmallDark,
                ),
            ):const SizedBox(),
          ),
          Selector<QuesHistoryProv, int>(
            selector: (context, prov) => prov.searchHistoryState,
            builder: (context, sta, child)=>
            sta==UIStateEnum.LOADING?UIKitBag.blue_loadingIndicator:const SizedBox(),
          ),
        ],
      ),
      floatingActionButton:Selector<QuesHistoryProv, bool>(
        selector: (context, prov) => prov.showJumpButton,
        builder: (context, show, child)=> show?getJumpButton(context, up: true, func: jumpToTop):const SizedBox(),
      ),
      floatingActionButtonLocation: CustomizeFloatingLocation(
        baseLocation: FloatingActionButtonLocation.endFloat,
        offsetY: -50,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
  void jumpToTop(){
    recordController.animateTo(
      0.0,
      duration: const Duration(milliseconds: AppRule.jumpTime),
      curve: Curves.easeOut,
    );
  }
  bool onNotification(ScrollEndNotification notification){
    print("pixels:${notification.metrics.pixels},maxScrollExtent:${notification.metrics.maxScrollExtent},screenH:$screenH");
    if(notification.metrics.pixels-notification.metrics.maxScrollExtent<AppRule.loadMoreEdge) {
      if(!qprov.over){
        qprov.showMoreButton = true;
      }
    }
    if(notification.metrics.pixels>screenH){
      qprov.showJumpButton=true;
    }else{
      qprov.showJumpButton=false;
    }
    return false;// 返回true表示消费了这个事件，不再向上传递
  }
}