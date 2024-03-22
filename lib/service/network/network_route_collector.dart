
// 这些route是需要持久化保存的，以应对后端api的变化,但是目前先不做这些了
class NetworkPathCollector {
  static const String host = "http://localhost:8099";

  static const String home = "/home";
  static const String signIn = "/sign_in";
  static const String signUp = "/sign_up";
  static const String resetPassword = "/reset_password";
  static const String profile = "/profile";
  static const String chat = "/chat";
}