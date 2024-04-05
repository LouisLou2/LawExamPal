import 'package:easy_cse/domain/entity/chat_info.dart';
import 'package:flutter/material.dart';
class ChatStateProv extends ChangeNotifier {

  late bool _waitForAnswer;
  late bool _showJumpButton;// 是否显示跳至底部的按钮
  // 由于复用机制，这里chatRecords不可调整顺序，否则在ui呈现会乱
  final List<ChatInfo> _chatRecords = [
    ChatInfo(false, '☺️我已查看该题目，请问有什么问题？'),
  ];

  ChatStateProv(){
    _waitForAnswer = false;
    _showJumpButton = false;
  }

  bool get waitForAnswer => _waitForAnswer;
  List<ChatInfo> get chatRecords => _chatRecords;
  ChatInfo get lastRecord => _chatRecords.last;
  bool get showJumpButton => _showJumpButton;

  set showJumpButton(bool value){
    _showJumpButton = value;
    notifyListeners();
  }
  @deprecated
  void autoAddRecord(ChatInfo info){
    _chatRecords.add(info);
    if(info.role){
      _waitForAnswer = true;
    }
  }
  void addUserRecord(String text){
    _chatRecords.add(ChatInfo(true, text));
    _waitForAnswer = true;
    notifyListeners();
  }
  void addModelRecord(String text){
    _chatRecords.add(ChatInfo(false, text));
    _waitForAnswer = false;
    notifyListeners();
  }
}