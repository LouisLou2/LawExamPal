import 'dart:async';
import 'package:dio/dio.dart';
import 'network_manager.dart';

class NoteWorker{
  static final Dio authDio = NetWorkWorker.normalWorker;
  static const bool debug = true;
  static late CancelToken _cancelToken;// 因为这三个请求不会同时进行，所以只需要一个CancelToken引用，注意如果是并发请求，每个请求CancelToken都要独立的对象

  static void init(){
    // 初始化
  }
  static void cancelRequest(){
    _cancelToken.cancel();
  }
}