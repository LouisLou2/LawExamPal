import 'package:easy_cse/domain/entity/resp_model/chat_session.dart';
import 'package:easy_cse/domain/entity/resp_model/new_chat_resp.dart';
import 'package:easy_cse/gui/widget/helper/snackbar_helper.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:easy_cse/service/network/chat_bot.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:easy_cse/service/provider/chat/chat_session_prov.dart';
import 'package:easy_cse/service/provider/chat/chat_state_prov.dart';
import 'package:easy_cse/service/provider/global/state_manager.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:tuple/tuple.dart';

class ChatHandler {
  static final ChatSessionProv csprov=ProvManager.chatSessionProv;
  static final ChatStateProv cprov=ProvManager.chatStateProv;
  static final StateManagerProv sprov=ProvManager.stateProv;

  static Future<void>sendQues(String ques)async {
    if(cprov.newChat){
      await sendFirstQuestion(ques);
    }else{
      await sendOngoingQues(ques);
    }
  }
  static void newChatPage(bool fromQues){
    cprov.enterPage(true, fromQues);
    // 这里仅仅进行ui的跳转，还不发送数据给后端，因为，如果用户只是打开该页面，却没有发送任何数据，这场会话没有保存的价值
    NavigationHelper.pushNamed(RouteCollector.chat);
  }
  static Future<void> sendFirstQuestion(String ques)async {
    // 进行第一条信息的发送，该条发送的背景(例如是否是从问题页跳转过来的)已经在
    // 先更改页面状态，变为加载中
    cprov.addUserRecordAndRefresh(ques);
    String token=sprov.user.token;
    bool fromQues=cprov.fromQues;
    final Tuple2<int,NewChatResp?> res=await ChatBot.sendFirstQues(token, ques, fromQues);
    if(res.item1!=ResultCode.SUCCESS){
      // 出错
      cprov.insertAErrorRecord();
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }else{
      NewChatResp resp=res.item2!;
      cprov.chatId=resp.chatId;
      cprov.addModelRecordAndRefresh(resp.ans);
      ChatSession session=ChatSession(chatId: resp.chatId, title: resp.title, lastChatTime:DateTime.now());
      csprov.addChatSession(session);
    }
  }
  static Future<void> sendOngoingQues(String ques)async {
    // 先更改页面状态，变为加载中
    cprov.addUserRecordAndRefresh(ques);
    String token=sprov.user.token;
    int chatId=cprov.chatId;
    final Tuple2<int,String?> res=await ChatBot.getAnswer(token, chatId, ques);
    if(res.item1!=ResultCode.SUCCESS){
      // 出错
      cprov.insertAErrorRecord();
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }else{
      String ans=res.item2!;
      cprov.addModelRecordAndRefresh(ans);
    }
  }
}