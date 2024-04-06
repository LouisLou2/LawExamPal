import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_cse/domain/entity/request_model/ques_recommend_param.dart';
import 'package:easy_cse/domain/entity/request_model/ques_search_id.dart';
import 'package:easy_cse/domain/entity/resp_model/ques_search_res.dart';
import 'package:easy_cse/domain/entity/resp_model/recommend_ques.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:tuple/tuple.dart';
import '../../domain/entity/request_model/ques_search_param.dart';
import '../../domain/entity/resp_model/response_body.dart';
import 'network_manager.dart';

class QuesWorker{
  static final Dio quesWorker = NetWorkWorker.normalWorker;
  static const bool debug = true;
  static late CancelToken _cancelToken;// 因为这三个请求不会同时进行，所以只需要一个CancelToken引用，注意如果是并发请求，每个请求CancelToken都要独立的对象

  static void init(){
    // 初始化
  }
  static void cancelRequest(){
    _cancelToken.cancel();
  }
  static Future<Tuple2<int,QuesSearchRes?>> searchQues({required String token, required String picPath}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await quesWorker.post(
        NetworkPathCollector.searchQues,
        data: FormData.fromMap(
          await QuesSearchParam(
            token: token,
            picPath: picPath,
          ).toJson(),
        ),
        options: NetWorkWorker.formdata_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      return Tuple2(respBody.code, QuesSearchRes.fromJson(respBody.data));
    }  on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }
  /*使用quesId获得答案解析*/
  static Future<Tuple2<int,QuesSearchRes?>> searchQuesByQuesId({required String token,required int quesId}) async{
    _cancelToken=CancelToken();
    try {
      Response response = await quesWorker.post(
        NetworkPathCollector.searchQuesByQuesId,
        data: QuesSearchIdParam(
            token: token,
            quesId: quesId
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      return Tuple2(respBody.code, QuesSearchRes.fromJson(respBody.data));
    }  on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }

  /*请求相似题目*/
  static Future<Tuple2<int,RecommendQues?>> getRecommendQues({required String token,int? quesId, String? ques}) async{
    assert((quesId==null || ques==null)&&(quesId!=null || ques!=null));// quesId和ques有且只有一个提供
    _cancelToken=CancelToken();
    try {
      Response response = await quesWorker.post(
        NetworkPathCollector.recommendQues,
        data: QuesRecommendParam(
            token: token,
            quesId: quesId,
            ques: ques
        ).toJson(),
        options: NetWorkWorker.json_json,
        cancelToken: _cancelToken,
      );
      RespBody respBody=RespBody.fromJson(response.data);
      if(respBody.code!=ResultCode.SUCCESS){
        return Tuple2(respBody.code, null);
      }
      return Tuple2(respBody.code, RecommendQues.fromJson(respBody.data));
    }  on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.ERROR, null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }
}