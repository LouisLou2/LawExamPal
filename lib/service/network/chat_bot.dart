import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_cse/domain/entity/request_model/new_chat_param.dart';
import 'package:easy_cse/domain/entity/request_model/ongoing_chat_param.dart';
import 'package:easy_cse/domain/entity/resp_model/new_chat_resp.dart';
import 'package:easy_cse/domain/entity/resp_model/response_body.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/network_manager.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:tuple/tuple.dart';

class ChatBot{
  static final Dio bot=NetWorkWorker.chatWorker;
  static const bool debug=true;
  static late CancelToken _cancelToken;
  static int nowTestInd=0;
  static void init(){

  }
  static void cancelQuery(){
    if(!_cancelToken.isCancelled){
      _cancelToken.cancel(['User Canceled it']);
    }
  }
  static Future<Tuple2<int,NewChatResp?>> sendFirstQues(String token,String ques,bool fromQues) async{
    _cancelToken=CancelToken();
    try {
      Response response = await bot.post(
        NetworkPathCollector.newChat,
        data: NewChatParam(
            token: token,
            ques: ques,
            fromQues: fromQues,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code,null);
      }
      NewChatResp newChatResp=NewChatResp.fromJson(respBody.data);
      return Tuple2(respBody.code,newChatResp);
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED,null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR,null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR,null);
    } finally{}
  }
  static Future<Tuple2<int,String?>> getAnswer(String token,int chatId,String ques) async{
    _cancelToken=CancelToken();
    try {
      Response response = await bot.post(
        NetworkPathCollector.chat,
        data: OngoingChatParam(
            token: token,
            chatId: chatId,
            ques: ques,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code,null);
      }
      return Tuple2(respBody.code,respBody.data['ans'] as String);
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED,null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR,null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR,null);
    } finally{}
  }
}