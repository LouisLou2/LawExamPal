import 'package:flutter/material.dart';
import '../../../domain/entity/resp_model/chat_session.dart';
class ChatSessionProv extends ChangeNotifier {

  late bool _waitForMore;
  late bool _showJumpButton;// 是否显示跳至底部的按钮
  // 由于复用机制，这里chatRecords不可调整顺序,可以追加,否则在ui呈现会乱
  late final List<ChatSession> _chatSessions;// 会话的记录
  late final int nowSession;// 当前会话

  ChatSessionProv(){
    _chatSessions=[];
    _waitForMore = false;
    _showJumpButton = false;
  }

  bool get waitForMore => _waitForMore;
  List<ChatSession> get chatSessions => _chatSessions;
  bool get showJumpButton => _showJumpButton;

  void disposeData(){
    _chatSessions.clear();
    _waitForMore = false;
    _showJumpButton = false;
  }

  void updateChatSession(int ind){
    _resortSessions(ind);
    notifyListeners();
  }

  void addChatSession(ChatSession chatSession){
    _chatSessions.add(chatSession);
    _resortSessions(_chatSessions.length-1);
    notifyListeners();
  }
  void setWaitForMore(bool value){
    _waitForMore = value;
    notifyListeners();
  }
  void setShowJumpButton(bool value){
    _showJumpButton = value;
    notifyListeners();
  }
  void setNowSession(int value){
    nowSession = value;
    notifyListeners();
  }
  void _resortSessions(int ind){
    // 保证除了ind其他都是从新到旧排序的
    int len=_chatSessions.length;
    if(len<=1)return;
    // ind为该会话在列表中的索引
    ChatSession session=_chatSessions[ind];
    DateTime time=session.lastChatTime;
    bool direc=false;// false左，true右
    if(ind==0){
      direc=true;
    }else if(ind==len-1){
      direc=false;
    }else{
      if(time.isBefore(_chatSessions[ind+1].lastChatTime)){
        direc=true;
      }
    }
    if(direc){
      int i=ind+1;
      while(i<=len-1){
        if(_chatSessions[i].lastChatTime.isBefore(time)){
          break;
        }
        ++i;
      }
      --i;
      for(int j=ind;j<=i-1;++j){
        _chatSessions[j]=_chatSessions[j+1];
      }
      _chatSessions[i]=session;
    }else{
      int i=ind-1;
      while(i>=0){
        if(_chatSessions[i].lastChatTime.isAfter(time)){
          break;
        }
        --i;
      }
      ++i;
      for(int j=ind;j>=i+1;--j){
        _chatSessions[j]=_chatSessions[j-1];
      }
      _chatSessions[i]=session;
    }
  }
}