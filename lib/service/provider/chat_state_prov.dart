import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
class ChatStateProv extends ChangeNotifier {

  late bool _allowChatType;
  late bool _waitForAnswer;
  late bool _lastIsModel;
  final List<Content> _chatRecords = [];

  ChatStateProv(){
    _allowChatType = true;
    _waitForAnswer = false;
    _lastIsModel = true;
  }

  bool get isAllowChatType => _allowChatType;
  bool get waitForAnswer => _waitForAnswer;

  List<Content> get chatRecords => _chatRecords;
  Content get lastRecord => _chatRecords.last;

  set allowChatType(bool value) {
    _allowChatType = value;
    notifyListeners();
  }
  set waitForAnswer(bool value) {
    _waitForAnswer = value;
    notifyListeners();
  }

  void clearChatRecords(){
    _chatRecords.clear();
    notifyListeners();
  }
  // 不通知，内部方法
  void _appendLastRecord(String text){
    _chatRecords.last.parts?.last.text='${_chatRecords.last.parts?.last.text}$text';
  }
  // 对外部提供的方法
  void autoAddChatRecord(String? text){
    if(text==null)return;
    if(_lastIsModel){
      _appendLastRecord(text);
    }else{
      _addModelChatRecord(text);
    }
    notifyListeners();
  }
  void _addModelChatRecord(String text){
    _chatRecords.add(Content(role: 'model', parts: [Parts(text: text)]));
    _lastIsModel = true;
  }
  void addUserChatRecord(String text){
    _chatRecords.add(Content(role: 'user', parts: [Parts(text: text)]));
    _lastIsModel = false;
    notifyListeners();
  }
}