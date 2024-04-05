import 'package:dio/dio.dart';

class QuesSearchParam{
  final String token;
  final String picPath;
  QuesSearchParam({
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