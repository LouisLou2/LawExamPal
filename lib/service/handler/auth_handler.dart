import 'package:easy_cse/constant/app_style/ui_fitter.dart';
import 'package:easy_cse/constant/situation_enum.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';

import '../../constant/app_string.dart';
import '../../domain/entity/persistence_kind/user.dart';
import '../../gui/widget/helper/dialog_helper.dart';
import '../../gui/widget/helper/snackbar_helper.dart';
import '../navigation/navigation_helper.dart';
import '../navigation/route_collector.dart';
import '../network/auth_worker.dart';
import '../network/resp_res_enum.dart';
import '../repository/db_handler.dart';

class AuthHandler {

  static Future<void> executeSignIn({required String email, required String password}) async {
    DialogHelper.showLoadingDialog(
      userCancel: AuthWorker.cancelRequest
    );
    final res=await AuthWorker.signIn(
      email: email,
      pwd: password,
    );
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    if(res.item1!=ResultCode.SUCCESS){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }
    int userId;
    User user=User.require(
      token: res.item2!,
      email: email,
      lastLoginTime: DateTime.now(),
    );
    userId=await DBHandler.addOrUpdateUser(user);
    user.id=userId;
    ProvManager.stateProv.user=user;
    DBHandler.setLastLoginUser(userId);
    NavigationHelper.pushReplacementNamed(RouteCollector.main);
  }

  static Future<void> executeSignUp({required String email, required String password}) async {
    DialogHelper.showLoadingDialog(
      userCancel: AuthWorker.cancelRequest
    );
    final res=await AuthWorker.signUp(
      email: email,
      pwd: password,
    );
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    if(res.item1!=ResultCode.SUCCESS){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }
    ProvManager.stateProv.user
      ..token=res.item2!
      ..email=email;
    NavigationHelper.pushNamed(RouteCollector.enter_veriCode);
  }

  static Future<void> executeSendVeriCode(String code) async {
    DialogHelper.showLoadingDialog(
      userCancel: AuthWorker.cancelRequest
    );
    final res=await AuthWorker.sendVeriCode(
      code: code,
      token: ProvManager.stateProv.user.token,
    );
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    if(res.item1!=ResultCode.SUCCESS){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }
    final sprov=ProvManager.stateProv;
    sprov.refreshLoginTime();
    sprov.user.id=await DBHandler.addOrUpdateUser(ProvManager.stateProv.user);
    DBHandler.setLastLoginUser(sprov.user.id);
    sprov.autoLogin();
    NavigationHelper.popAllAndPushNamed(RouteCollector.edit_profile);
  }

  static Future<void> executeRequestVeriCode() async {
    // 这个就不需要loadingDialog了，小题大做，况且用户可以看到倒计时
    final res=await AuthWorker.requestVeriCode(
      token: ProvManager.stateProv.user.token,
    );
    if(res!=ResultCode.SUCCESS) {
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res));
      return;
    }
    SnackbarHelper.showToaster(
      title: AppStrings.veriCodeSent,
      kind: SituationEnum.SUCCESS,
    );
  }

  static void logout() {
    DBHandler.setLastLoginUser(null);
    ProvManager.stateProv.logout();
    NavigationHelper.popAllAndBoard();
  }
}