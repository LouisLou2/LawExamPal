import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/service/provider/chat/chat_state_prov.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// 此组件是需要监听provider的: UserStateProv
// 他不是可以直接复用的组件

class ChatInputBox extends StatefulWidget{
  const ChatInputBox({
    super.key,
    this.onSendClicked,
    this.onCameraClicked,
    required this.controller,
    this.textFiledColor,
    this.buttonColor,
    this.disableColor,
    this.onCancelClicked,
    required this.getIfWaiting,
  });
  final VoidCallback? onSendClicked;
  final VoidCallback? onCameraClicked;
  final VoidCallback? onCancelClicked;
  final bool Function() getIfWaiting;
  final Color? textFiledColor;
  final Color? buttonColor;
  final Color? disableColor;

  final TextEditingController controller;
  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();
}
class _ChatInputBoxState extends State<ChatInputBox>{
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(widget.onCameraClicked != null)
            Padding(
              padding: const EdgeInsets.all(4),
              child: IconButton(
                onPressed: widget.onCameraClicked,
                color: widget.buttonColor??AppColors.silentBlue,
                icon: const Icon(Icons.file_copy_rounded),
              )
            ),
          Expanded(
            child: TextField(
              controller:widget.controller,
              minLines: 1,
              maxLines: 6,
              cursorColor: Theme.of(context).colorScheme.inversePrimary,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                hintText: ' Message',
                border: InputBorder.none,
              ),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              // 意思是点击外部的时候，让键盘消失
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              icon:Selector<ChatStateProv,bool>(
                selector: (context,prov) => prov.waitForAnswer,
                builder: (context,waiting,child)=>waiting?
                Icon(
                  CupertinoIcons.stop_circle,
                  color: widget.disableColor??AppColors.darkText0,
                ):
                Icon(CupertinoIcons.paperplane,
                      color: widget.buttonColor??AppColors.silentBlue,
                ),
              ), onPressed: ()=>widget.getIfWaiting.call()?
                                widget.onCancelClicked?.call():
                                widget.onSendClicked?.call(),
            ),
          ),
        ],
      )
    );
  }
}