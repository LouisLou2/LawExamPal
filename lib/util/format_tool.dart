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

  static String _twoDigit(int num) {
    return num < 10 ? '0$num' : '$num';
  }
  // 用于展示(都是本地时间，数字不足两位会补全)
  static String dateScaleStr(DateTime date){
    // 需要0补足
    return '${date.year}-${_twoDigit(date.month)}-${_twoDigit(date.day)}';
  }
  static String secScaleStr(DateTime date){
    return '${date.year}-${_twoDigit(date.month)}-${_twoDigit(date.day)} ${_twoDigit(date.hour)}:${_twoDigit(date.minute)}:${_twoDigit(date.second)}';
  }
  // 用于传输(都是utc时间,数字不足两位会补全)
  static String utcDateScaleStr(DateTime date){
    return dateScaleStr(date.toUtc());
  }
  static String utcSecScaleStr(DateTime date){
    return secScaleStr(date.toUtc());
  }
}