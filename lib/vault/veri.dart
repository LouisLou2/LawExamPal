import 'dart:async';

import 'package:easy_cse/constant/app_rule.dart';
import 'package:flutter/cupertino.dart';

class VeriCodeeProv extends ChangeNotifier {
  final int gap=60;
  final int len=6;

  late String veriCode;// 6位数字字符
  late int index;// 现在正在等待用户输入的验证码的位置，0-5

  late int pauseInterval;// 暂停间隔
  int? lastPauseTime;// 上次暂停的时间
  late int lastSendTime=0;// 上次发送验证码的时间

  bool allowNextSend=false;

  StreamController<int>? streamController;
  Stream<int>?stream;

  void reset(){
    veriCode = AppRule.invalidChar*len; //a为无效验证码,即还未输入验证码
    index = 0;
    pauseInterval=0;
  }

  VeriCodeeProv(){
    reset();
  }

  Stream<int> startTimer(){
    if(stream!=null){
      return stream!;
    }
    pauseInterval=0;
    // 计算距离上次发送验证码的时间
    int left=gap-(DateTime.now().millisecondsSinceEpoch-lastSendTime)~/1000;
    // 如果left<=0，说明上次发送验证码的时间距离现在已经超过60s
    if(left<=0){
      lastSendTime=DateTime.now().millisecondsSinceEpoch;
      left=gap;
    }
    streamController = StreamController<int>();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int value=left-pauseInterval;
      if (value >= 0) {
        streamController!.add(value);
        --left;
      } else {
        streamController!.close();
        timer.cancel();
        allowNext(true);
      }
    });
    stream=streamController!.stream;
    return stream!;
  }

  set setSendTime(int time){
    lastSendTime = time;
  }

  set addSecond(int second){
    pauseInterval = second;
  }

  set setVeriCode(String code){
    veriCode = code;
    veriCode = veriCode.padRight(len, AppRule.invalidChar);
    index = code.length;
    notifyListeners();
  }
  void allowNext(bool allow){
    // 将显示“重新发送”的按钮
    allowNextSend=allow;
    stream = null;
    notifyListeners();
  }
  String get getVeriCode{
    return veriCode;
  }
  String getCharAt(int i){
    return veriCode[i];
  }
}