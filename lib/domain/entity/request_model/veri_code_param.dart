class VeriCodeParam{
  String token;
  String code;

  VeriCodeParam({
    required this.token,
    required this.code,
  });

  Map<String,dynamic> toJson(){
    return {
      'token': token,
      'code': code,
    };
  }
}