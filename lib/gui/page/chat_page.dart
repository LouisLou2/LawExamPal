import "package:easy_cse/gui/widget/chat_item.dart";
import "package:easy_cse/service/network_manager/chat_bot.dart";
import "package:easy_cse/service/provider/chat_state_prov.dart";
import "package:easy_cse/service/provider/prov_manager.dart";
import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:provider/provider.dart";

import "../../constant/app_style/app_color.dart";
import "../widget/chat_input_box.dart";
import "../widget/empty_chat_widget.dart";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() =>_ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  static const String mode='AI Chat[Stream Mode]';

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    final cprov = Provider.of<ChatStateProv>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(mode),
      ),
      body: Column(
        children: [
          Expanded(
            child:cprov.chatRecords.isEmpty?
            const EmptyChatWidget():
            Align(
              alignment: Alignment.topCenter,
              child: Selector<ChatStateProv, int>(
                selector: (context, prov) {
                    print("@@@@@@@@@@@@@Length");
                    print(prov.chatRecords.length);
                    return prov.chatRecords.length;
                  },
                builder: (context, len, child)=> ListView.builder(
                  key: ValueKey<int>(len),
                  itemBuilder: (BuildContext context, int index){
                    print("@@@@@@@@@@@@@index");
                    print(index);
                    return ChatItem(
                      recordIndex: index,
                      key: ValueKey<String>(cprov.chatRecords[index].parts?.lastOrNull?.text ?? 'Unknown'),
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
          Selector<ChatStateProv, bool>(
            selector: (context, prov) => prov.waitForAnswer,
            builder: (context, loading, child)=>
            loading?const CircularProgressIndicator(
              color: AppColors.silentBlue,
            ):const SizedBox(),
          ),
          ChatInputBox(
            controller: controller,
            onCameraClicked: (){},
            onSendClicked: onSend,
            buttonColor: AppColors.silentBlue,
          )
        ],
      ),
    );
  }
  void onSend(){
    if(controller.text.isEmpty)return;
    final cprov=ProvManager.chatStateProv;
    final searchedText = controller.text;
    cprov.addUserChatRecord(searchedText);
    controller.clear();
    cprov.waitForAnswer=true;
    cprov.allowChatType=false;
    ChatBot.bot.streamChat(cprov.chatRecords).listen((value){
      cprov.waitForAnswer=false;
      cprov.autoAddChatRecord(value.output);
    },
      onDone: onAnswerDone,
    );
  }

  void onAnswerDone(){
    ProvManager.chatStateProv.allowChatType=true;
  }
}