import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/service/provider/chat_state_prov.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constant/app_style/app_style.dart';
// 此组件是高度特化的组件，不适合复用，里面的样式逻辑都是固定的
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
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ListTile(
        isThreeLine: true,
        horizontalTitleGap: 10,
        tileColor: record.role? AppColors.purpleBlue: AppColors.white1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIParams.smallBorderR),
        ),
        leading: CircleAvatar(
          child: Text((record.role?AppStrings.user:AppStrings.chatBot)[0]),
        ),
        title: Text(
          record.role?AppStrings.user:AppStrings.chatBot,
          style:record.role? AppStyles.bodySmall.copyWith(color: AppColors.white1, fontWeight: FontWeight.bold)
              : AppStyles.bodySmall.copyWith(color: AppColors.darkText1, fontWeight: FontWeight.bold),
        ),
        subtitle: record.role? Text(
          record.text,
          style: AppStyles.bodySmall,
        ):
        Selector<ChatStateProv, int>(
          selector: (context, prov) => prov.chatRecords[widget.recordIndex].text.length,
          builder: (context,_, child)=>
          SelectionArea(
            child:Markdown(
              selectable: false,
              controller: ScrollController(),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              data: record.text,
            ),
          ),
        ),
      ),
    );
  }
}
