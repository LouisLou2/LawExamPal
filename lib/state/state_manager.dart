import 'package:easy_cse/state/user.dart';

class StateManager{
  static late User _user;
  static void init() {
    // 目前逻辑还不完全，只是简单的初始化，之后会改
    _user = User()..init();
  }
  static void loginAndNav() {
    // 取出数据库中的用户信息
    // 判断用户是否首次登录，然后进行相应的操作，并将服务端返回信息记录
  }

  static User get user => _user;
}