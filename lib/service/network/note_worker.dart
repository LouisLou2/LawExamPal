import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_cse/domain/entity/resp_model/response_body.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:tuple/tuple.dart';
import '../../domain/entity/request_model/note_request_param.dart';
import 'network_manager.dart';

class NoteWorker{
  static final Dio authDio = NetWorkWorker.normalWorker;
  static const bool debug = true;
  static late CancelToken _cancelToken;// 因为这三个请求不会同时进行，所以只需要一个CancelToken引用，注意如果是并发请求，每个请求CancelToken都要独立的对象

  static void init(){
    // 初始化
  }
  static void cancelRequest() {
    _cancelToken.cancel();
  }
  static Future<Tuple2<int,String?>> getNoteFileUrl(String token,String filePath)async{
    _cancelToken = CancelToken();
    try{
      Response response = await authDio.post(
        NetworkPathCollector.getNoteUrl,
        data: NoteReqParam(
          token: token,
          filePath: filePath,
        ).toJson(),
        options: NetWorkWorker.formdata_json,
        cancelToken: _cancelToken,
      );
      final data = response.data;
      RespBody resp = RespBody.fromJson(data);
      if(resp.code != ResultCode.SUCCESS){
        return Tuple2(resp.code, null);
      }
      return Tuple2(resp.code, resp.data['fileUrl'] as String);
    }on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return const Tuple2(ResultCode.USER_CANCELED, null);
      }
      else if(isTimeOutException(e)){
        return const Tuple2(ResultCode.TIME_OUT, null);
      }
      return const Tuple2(ResultCode.FILE_GENERATE_FAILED, null);
    } catch (e) {
      return const Tuple2(ResultCode.DEBUG_ERROR, null);
    }
  }
  static Future<int> downloadNoteFile(String url,String savePath)async{
    _cancelToken = CancelToken();
    try{
      Response response = await authDio.download(
        url,
        savePath,
        cancelToken: _cancelToken,
      );
      return response.statusCode==200?ResultCode.SUCCESS:ResultCode.ERROR;
    }on DioException catch (e) {
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