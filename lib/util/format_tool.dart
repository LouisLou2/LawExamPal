class FormatTool {
  static final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$', caseSensitive: true, multiLine: false);
  //确保字符串由字母、数字，并且总长度为8-20个字符。
  static final RegExp pwdRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,20}$',caseSensitive: true, multiLine: false);
  static final RegExp onlyNumberRegex = RegExp(r'^[0-9]+$',caseSensitive: true, multiLine: false);
  static bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }
  static bool isPwdValid(String password) {
    return pwdRegex.hasMatch(password);
  }
  static String dateScaleString(DateTime date){
    return '${date.year}-${date.month}-${date.day}';
  }
  // 2024-4-10并且是Utc时间
  static String utcDateScaleString(DateTime date){
    DateTime utc = date.toUtc();
    return '${utc.year}-${utc.month}-${utc.day}';
  }
  static String secScaleStr(DateTime date){
    return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
  }
}