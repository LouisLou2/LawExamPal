import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_cse/domain/entity/request_model/user_detail_param.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';

import '../../domain/entity/persistence_kind/user.dart';
import '../../domain/entity/resp_model/response_body.dart';
import 'network_manager.dart';

class UserInfoWorker{
  static final Dio authDio = NetWorkWorker.normalWorker;
  static const bool debug = true;
  static late CancelToken _cancelToken;// 因为这三个请求不会同时进行，所以只需要一个CancelToken引用，注意如果是并发请求，每个请求CancelToken都要独立的对象

  static void init(){
    // 初始化
  }
  static void cancelRequest(){
    _cancelToken.cancel();
  }
  static Future<int> updateUserInfo(User user) async{
    _cancelToken=CancelToken();
    try {
      Response response = await authDio.post(
        NetworkPathCollector.updateUserInfo,
        data: FormData.fromMap(await UserDetail.fromUser(user).toJson(),),
        options: NetWorkWorker.formdata_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      return respBody.code;
    }  on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return ResultCode.USER_CANCELED;
      }
      else if(isTimeOutException(e)){
        return ResultCode.TIME_OUT;
      }
      return ResultCode.ERROR;
    } catch (e) {
      return ResultCode.DEBUG_ERROR;
    }
  }
}