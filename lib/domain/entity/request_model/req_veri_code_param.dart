// 不是我过度封装，只是为了之后如果有参数变动，可以方便的修改
class ReqVeriCodeParam{
  String token;
  ReqVeriCodeParam({required this.token});
  Map<String,dynamic> toJson(){
    return {
      'token':token,
    };
  }
}