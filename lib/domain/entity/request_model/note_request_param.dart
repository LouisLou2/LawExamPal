import 'package:dio/dio.dart';

class NoteReqParam{
  final String token;
  final String filePath;
  NoteReqParam({
    required this.token,
    required this.filePath,
  });

  Future<Map<String, dynamic>> toJson() async{
    MultipartFile pic=await MultipartFile.fromFile(filePath);
    return {
      'token': token,
      'file':pic,
    };
  }
}