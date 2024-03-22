import 'package:dio/dio.dart';
import 'package:easy_cse/config/resp_code_enum.dart';
import 'package:easy_cse/domain/entity/response_body.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/network_worker.dart';
import 'package:easy_cse/state/state_manager.dart';

class ChatBot{
  static final Dio bot=NetWorkWorker.chatWorker;
  static const bool debug=true;
  static void init(){

  }
  static Future<String?> getAnswer(String query) async{
    // dio请求，向localhost请求
    try {
      Response response = await bot.post(
        NetworkPathCollector.chat,
        data: {
          'id': StateManager.user.userId,
          'ques': query,
        },
        options: Options(
          responseType: ResponseType.json, // 指定响应类型为纯文本
        ),
      );
      final data=response.data;
      RespBody respBody=RespBody.fromJson(data);
      if(respBody.code!=RespCode.SUCCESS){
        return null;
      }
      return respBody.data as String;
    } catch (e) {
      return e.toString();
    } finally{}
  }
}