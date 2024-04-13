import "package:easy_cse/constant/app_rule.dart";
import "package:easy_cse/constant/app_string.dart";
import "package:easy_cse/constant/app_style/app_style.dart";
import "package:easy_cse/presentation/widget/buttons/jump_button.dart";
import "package:easy_cse/presentation/widget/chat_item.dart";
import "package:easy_cse/presentation/widget/config/floating_location.dart";
import "package:easy_cse/presentation/widget/layout_helper_widget/named_divider.dart";
import "package:easy_cse/service/file_manager/image_manger.dart";
import "package:easy_cse/service/handler/chat_handler.dart";
import "package:easy_cse/service/provider/chat/chat_state_prov.dart";
import "package:easy_cse/service/provider/prov_manager.dart";
import "package:easy_cse/util/extensions.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";

import "../../../constant/app_style/app_color.dart";
import "../../../constant/app_style/app_pic.dart";
import "../../../service/network/chat_bot.dart";
import "../../widget/chat_input_box.dart";
import "../../widget/empty_chat_widget.dart";

/*先不设置ListView中的key了*/

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() =>_ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  final queryController = TextEditingController();
  final recordController = ScrollController();
  late final double screenH;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenH = context.heightFraction();
      if(recordController.hasClients) {
        recordController.jumpTo(
          recordController.position.maxScrollExtent,
        );
      }
    });
  }
  @override
  void dispose(){
    queryController.dispose();
    recordController.dispose();
    ProvManager.chatStateProv.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
            AppStrings.aiTutorEmoji,
            style:AppStyles.iconTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: AppColors.discoBallBlue,
        centerTitle: true,
        toolbarHeight: 50,
      ),
      drawer: const ChatDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Selector<ChatStateProv, bool>(
              selector: (context, prov)=> prov.chatRecords.isEmpty,
              builder: (context, isEmpty, child)=>isEmpty?
              const EmptyWidget(text:AppStrings.emptyChat):
              Align(
                alignment: Alignment.topCenter,
                child: NotificationListener<ScrollEndNotification>(
                  // 不使用ScrollController::addListener,使用外层包裹的NotificationListener, ScrollEndNotification是用户停止滑动的时候触发
                  onNotification: onNotification,
                  child: Selector<ChatStateProv, int>(
                    selector: (context, prov)=> prov.chatRecords.length,
                    builder: (context, len, child)=>ListView.builder(
                      controller: recordController,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatItem(
                          recordIndex: index,
                        );
                      },
                      itemCount: len,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Selector<ChatStateProv, bool>(
            selector: (context, prov) => prov.waitForAnswer,
            builder: (context, loading, child)=>
            loading?const CircularProgressIndicator(
              color: AppColors.silentBlue,
            ):const SizedBox(),
          ),
          ChatInputBox(
            controller: queryController,
            onCameraClicked: pickImage,
            onSendClicked: onSend,
            onCancelClicked: onCancel,
            buttonColor: AppColors.silentBlue,
            getIfWaiting: ()=>ProvManager.chatStateProv.waitForAnswer,
          ),
        ],
      ),
      floatingActionButton:Selector<ChatStateProv, bool>(
        selector: (context, prov) => prov.showJumpButton,
        builder: (context, show, child)=>
        show?getJumpButton(context, up: false, func: jumpToBottom):const SizedBox(),
      ),
      floatingActionButtonLocation: CustomizeFloatingLocation(
        baseLocation: FloatingActionButtonLocation.endFloat,
        offsetY: -50,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
  void onSend() async{
    if(queryController.text.isEmpty)return;
    String ques=queryController.text;
    queryController.clear();
    await ChatHandler.sendQues(ques);
    jumpToBottom();
  }
  void pickImage() async{
    await ImageManager.imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50
    ).then((value) {}
    );
  }
  void jumpToBottom(){
    recordController.animateTo(
      recordController.position.maxScrollExtent,
      duration: const Duration(milliseconds: AppRule.jumpTime),
      curve: Curves.easeOut,
    );
  }
  bool onNotification(ScrollEndNotification notification){
    // 这里的逻辑是当向上滑动超过x像素时，显示一个按钮，点击按钮后才滚动到底部
    // pixels是当前滚动的位置，maxScrollExtent是最大滚动位置
    if(notification.metrics.pixels<notification.metrics.maxScrollExtent-screenH){
      ProvManager.chatStateProv.showJumpButton=true;
    }else{
      ProvManager.chatStateProv.showJumpButton=false;
    }
    return false;// 返回true表示消费了这个事件，不再向上传递
  }
  void onCancel(){
    ChatBot.cancelQuery();
  }
}

class ChatDrawer extends StatefulWidget{
  const ChatDrawer({super.key});

  @override
  State<StatefulWidget> createState() => _ChatDrawerState();
}
class _ChatDrawerState extends State<ChatDrawer>{
  @override
  Widget build(BuildContext context){
    return Drawer(
      width: 0.7.sw,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            tileColor: AppColors.white1,
            contentPadding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
            leading: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppPic.logo),
            ),
            title: Text(
              AppStrings.newChat,
              style: AppStyles.bodySmallDark.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.edit_note_rounded,
              size: 30,
            ),
            onTap: ()=>ChatHandler.newChatPage(false),
          ),
          NamedDivider(
            name: AppStrings.history_records,
            textColor: AppColors.darkText2,
            height: 30,
            fontSize: 40.sp,
            dividerHeight: 1,
          ),
          Expanded(
            child:MediaQuery.removePadding(//解决出现的空白问题
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(
                      "Item $index",
                      style: AppStyles.bodySmallDark,
                    ),
                    onTap: (){},
                  );
                },
                itemCount: 20,
              ),
            ),
          ),
        ],
      )
    );
  }
}