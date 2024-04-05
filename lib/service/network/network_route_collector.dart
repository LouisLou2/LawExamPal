
// 这些route是需要持久化保存的，以应对后端api的变化,但是目前先不做这些了
class NetworkPathCollector {
  static const String host = "http://192.168.5.101:8091";
  // 分类
  static const String account = "/account";
  static const String content = "/content";
  static const String ques = "/ques";
  static const String note = "/note";
  static const String chat = "/chat";
  // account
  static const String signIn = "$account/sign_in";
  static const String signUp = "$account/sign_up";
  static const String sendVerifyCode = "$account/check_code";
  static const String verifyCode = "$account/request_veri_code";
  static const String updateUserInfo = "$account/update_info";
  // ques
  static const String searchQues = "$ques/search_ques";
  static const String searchQuesByQuesId = "$ques/search_quesId";
  static const String recommendQues= '$ques/recommend';
  // note
  // chat
  static const String normalChat = "$chat/ongoing";
  static const String newChat = "$chat/new";
}