import 'package:easy_cse/service/navigation/navigation_helper.dart';

import '../state/user.dart';

class ModelStateManager{
  static final User _user = User.instance;
  static void loginAndNav() {
    _user.login();
    NavigationHelper.pushReplacementNamed('/main');
  }
}