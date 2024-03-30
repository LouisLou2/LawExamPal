import 'dart:async';

import 'package:easy_cse/constant/app_rule.dart';
import 'package:flutter/cupertino.dart';

class VeriCodeProv extends ChangeNotifier {
  final int gap=60;
  final int len=6;
  int left=60;
  late String veriCode;// 6位数字字符
  late int index;// 现在正在等待用户输入的验证码的位置，0-5

  late int pauseInterval;// 暂停间隔
  int? lastPauseTime;// 上次暂停的时间

  bool allowNextSend=false;
  Timer? timer;

  void reset(){
    veriCode = AppRule.invalidChar*len; //a为无效验证码,即还未输入验证码
    index = 0;
    pauseInterval=0;
  }

  VeriCodeProv(){
    reset();
  }

  void startTimer(){
    if(timer!=null&&timer!.isActive){
      return;
    }
    pauseInterval=0;
    // 计算距离上次发送验证码的时间
    left=gap;
    print("@@@@@@@@@@@@@@@@ new timer instance");
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      if(pauseInterval!=0){
        left-=pauseInterval;
        pauseInterval=0;
      }
      if (left > 0) {
        --left;
        notifyListeners();
      } else {
        timer.cancel();
        allowNext(true);
      }
    });
  }

  set setVeriCode(String code){
    veriCode = code;
    veriCode = veriCode.padRight(len, AppRule.invalidChar);
    index = code.length;
    notifyListeners();
  }
  void allowNext(bool allow){
    if(allowNextSend==allow){
      return;
    }
    // 将显示“重新发送”的按钮
    allowNextSend=allow;
    if(!allow){
      startTimer();
    }
    notifyListeners();
  }
  String get getVeriCode{
    return veriCode;
  }
  String getCharAt(int i){
    return veriCode[i];
  }
}