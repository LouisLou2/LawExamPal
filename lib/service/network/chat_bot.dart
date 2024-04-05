import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/domain/entity/response_body.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/network_manager.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/test_data/test_data.dart';

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
  static Future<String?> getAnswer(String query) async{
    _cancelToken=CancelToken();
    // dio请求，向localhost请求
    try {
      Response response = await bot.post(
        NetworkPathCollector.chat,
        data: {
          'token': ProvManager.stateProv.user.token,
          'ques': query,
        },
        options: Options(
          responseType: ResponseType.json, // 指定响应类型为纯文本
        ),
        cancelToken: _cancelToken,
      );
      final data=response.data;
      RespBody respBody=RespBody.fromJson(data);
      if(respBody.code!=ResultCode.SUCCESS){
        return null;
      }
      return respBody.data as String;
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return AppStrings.cancelQuery;
      }
      return TestData.talkList[(nowTestInd++)%(TestData.talkList.length)];
    } finally{}
  }
}