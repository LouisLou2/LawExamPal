
// 这些route是需要持久化保存的，以应对后端api的变化,但是目前先不做这些了
class NetworkPathCollector {
  static const String host = "http://192.168.5.101:8091";

  static const String account = "/account";
  static const String content = "/content";

  static const String signIn = "$account/sign_in";
  static const String signUp = "$account/sign_up";
  static const String sendVerifyCode = "$account/check_code";
  static const String verifyCode = "$account/request_veri_code";
  static const String updateUserInfo = "$account/update_info";
  static const String searchQues = "$content/search_ques";
  static const String chat = "/chat";
}