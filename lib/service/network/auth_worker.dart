import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_cse/domain/entity/request_model/email_password_param.dart';
import 'package:easy_cse/domain/entity/request_model/veri_code_param.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:tuple/tuple.dart';

import '../../domain/entity/request_model/req_veri_code_param.dart';
import '../../domain/entity/resp_model/response_body.dart';
import 'network_manager.dart';

class AuthWorker{
  static final Dio authDio = NetWorkWorker.normalWorker;
  static const bool debug = true;
  static late CancelToken _cancelToken;// 因为这三个请求不会同时进行，所以只需要一个CancelToken引用，注意如果是并发请求，每个请求CancelToken都要独立的对象

  static void init(){
    // 初始化
  }
  static void cancelRequest(){
    _cancelToken.cancel();
  }
  static Future<Tuple2<int,String?>> signIn({required String email, required String pwd}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await authDio.post(
        NetworkPathCollector.signIn,
        data: EmailPasswordParam(
          email: email,
          password: pwd,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      return Tuple2(respBody.code, respBody.data['token'] as String);
    }  on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    } on Exception catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }

  static Future<Tuple2<int,String?>> signUp({required String email, required String pwd}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await authDio.post(
        NetworkPathCollector.signUp,
        data: EmailPasswordParam(
          email: email,
          password: pwd,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      // 说明token有了，验证码也发了
      return Tuple2(respBody.code, respBody.data['token'] as String);
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    }on Exception catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }

  static Future<int> requestVeriCode({required String token}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await authDio.post(
        NetworkPathCollector.verifyCode,
        data: ReqVeriCodeParam(
          token: token,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      return respBody.code;//处理结果
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return ResultCode.USER_CANCELED;
      }
      else if(isTimeOutException(e)){
        return ResultCode.TIME_OUT;
      }
      return ResultCode.ERROR;
    } on Exception catch (e) {
      return ResultCode.DEBUG_ERROR;
    }
  }
  static Future<Tuple2<int,bool?>> sendVeriCode({required String token,required String code}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await authDio.post(
        NetworkPathCollector.sendVerifyCode,
        data: VeriCodeParam(
          token: token,
          code: code,
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      return Tuple2(respBody.code, respBody.data['match'] as bool);
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    } on Exception catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }
}