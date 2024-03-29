import 'dart:async';

import 'package:easy_cse/constant/app_rule.dart';
import 'package:flutter/cupertino.dart';

class VeriCodeProv extends ChangeNotifier {
  final int len=6;
  late String veriCode;// 6位数字字符
  late int index;// 现在正在等待用户输入的验证码的位置，0-5
  late int pauseTime;// 暂停时间
  late int lastSendTime;// 上次发送验证码的时间

  void init(){
    veriCode = AppRule.invalidChar*len; //a为无效验证码,即还未输入验证码
    index = 0;
  }
  VeriCodeProv(){
    init();
  }
  Stream<int> startTimer(){
    final Stream<int> myStream = Stream.periodic(const Duration(seconds: 1), (int count) =>60 - count - pauseTime)
        .takeWhile((value) => value >= 0); // 当 value 小于 0 时停止取值
    return myStream;
  }
  set setSendTime(int time){
    lastSendTime = time;
  }
  set addSecond(int second){
    pauseTime = second;
  }
  set setVeriCode(String code){
    veriCode = code;
    veriCode = veriCode.padRight(len, AppRule.invalidChar);
    index = code.length;
    notifyListeners();
  }
  String get getVeriCode{
    return veriCode;
  }
  String getCharAt(int i){
    return veriCode[i];
  }
}