import 'package:easy_cse/domain/entity/resp_model/chat_info.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_string.dart';

class ChatStateProv extends ChangeNotifier {
  late bool newChat;
  late int chatId;//对应的会话的id
  late bool fromQues;// 现在是不是从问题页跳转过来的，可以是从问题页跳转过来的，也可以是普通的发起谈话，还可以现在是历史记录
  late bool over;// 当划到最顶层还要不要继续网络加载的标志
  late bool _waitForAnswer;
  late bool _showJumpButton;// 是否显示跳至底部的按钮
  // 由于复用机制，这里chatRecords不可调整顺序,可以追加,否则在ui呈现会乱
  late final List<ChatInfo> _chatRecords;// 一个talk session的记录

  ChatStateProv(){
    newChat=true;
    over = false;
    _chatRecords=[];
    fromQues=false;
    _waitForAnswer = false;
    _showJumpButton = false;
  }

  bool get waitForAnswer => _waitForAnswer;
  List<ChatInfo> get chatRecords => _chatRecords;
  ChatInfo get lastRecord => _chatRecords.last;
  bool get showJumpButton => _showJumpButton;

  void _insertWaitingRecord(){
    _chatRecords.add(ChatInfo(false, AppStrings.tellMeYourQuestion));
    // 这里不用notifyListeners,因为之后才会显示界面
  }
  void insertAErrorRecord(){
    _chatRecords.add(ChatInfo(false, AppStrings.somethingWentWrong));
    notifyListeners();
  }

  void enterPage(bool isNewChat,bool fromQues){
    // newChat表示是否是新的会话，fromQues表示是否是从问题页跳转过来的
    assert (newChat||!fromQues);// 如果不是新的会话，那么也无谓从哪来跳转来的了,如果newChat==false, fromQues忽视即可
    newChat=isNewChat;
    if(newChat){
      over=true;
      fromQues = fromQues;
      if(fromQues){
        _insertWaitingRecord();
      }
    }
  }
  void enterPageFromHistory(){

  }

  void disposeData(){
    over = false;
    _chatRecords.clear();
    _waitForAnswer = false;
    _showJumpButton = false;
    newChat=true;
  }

  set showJumpButton(bool value){
    _showJumpButton = value;
    notifyListeners();
  }
  void addUserRecordAndRefresh(String text){
    _chatRecords.add(ChatInfo(true, text));
    _waitForAnswer = true;
    notifyListeners();
  }
  void addModelRecordAndRefresh(String text){
    _chatRecords.add(ChatInfo(false, text));
    _waitForAnswer = false;
    notifyListeners();
  }
}