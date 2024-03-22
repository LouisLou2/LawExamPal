import 'package:easy_cse/domain/entity/chat_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
class ChatStateProv extends ChangeNotifier {

  late bool _waitForAnswer;

  // 由于复用机制，这里chatRecords不可调整顺序，否则在ui呈现会乱
  final List<ChatInfo> _chatRecords = [];

  ChatStateProv(){
    _waitForAnswer = false;
  }

  bool get waitForAnswer => _waitForAnswer;
  List<ChatInfo> get chatRecords => _chatRecords;
  ChatInfo get lastRecord => _chatRecords.last;

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
  void stopWait(){
    // 具体实现还没想好
    _waitForAnswer = false;
    notifyListeners();
  }
}