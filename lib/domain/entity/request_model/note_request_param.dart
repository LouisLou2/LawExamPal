import 'package:dio/dio.dart';

class NoteReqParam{
  final String token;
  final String picPath;
  NoteReqParam({
    required this.token,
    required this.picPath,
  });

  Future<Map<String, dynamic>> toJson() async{
    MultipartFile pic=await MultipartFile.fromFile(picPath);
    return {
      'token': token,
      'pic':pic,
    };
  }
}