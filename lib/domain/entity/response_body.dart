// 返回体的wrapper
class RespBody {
  final int code;
  // message和data都可能是null
  final String? message;
  final dynamic data;

  RespBody(this.code, {this.message, this.data});

  factory RespBody.fromJson(Map<String, dynamic> json) {
    int code=json['code'] as int;
    return RespBody(
      code,
      message: json['message'],
      data: json['data'],
    );
  }
}