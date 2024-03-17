class User{
  bool _login = false;
  bool get isLoggedIn => _login;
  void login() {
    _login = true;
  }
  //单例
  static final User _instance = User();
  static User get instance => _instance;
}