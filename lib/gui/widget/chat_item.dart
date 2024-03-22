import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/service/provider/chat_state_prov.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatefulWidget{
  final int recordIndex;
  const ChatItem({Key? key, required this.recordIndex,}) : super(key: key);
  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem>{
  @override
  Widget build(BuildContext context){
    final cprov = ProvManager.chatStateProv;
    final record = cprov.chatRecords[widget.recordIndex];
    return Card(
      elevation: 0,
      color: record.role? AppColors.white0 : AppColors.blue1,
      child:Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(record.role?AppStrings.user:AppStrings.chatBot),
            Selector<ChatStateProv, int>(
              selector: (context, prov) => prov.chatRecords[widget.recordIndex].text.length,
              builder: (context,_, child)=>
              Markdown(
                controller: ScrollController(),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                data: cprov.chatRecords[widget.recordIndex].text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
