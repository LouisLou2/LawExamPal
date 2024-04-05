import 'package:easy_cse/constant/situation_enum.dart';
import 'package:easy_cse/service/file_manager/image_manger.dart';
import 'package:easy_cse/service/network/user_info_worker.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/global/state_manager.dart';
import '../../constant/app_style/ui_fitter.dart';
import '../../gui/widget/helper/dialog_helper.dart';
import '../../gui/widget/helper/snackbar_helper.dart';
import '../navigation/navigation_helper.dart';
import '../navigation/route_collector.dart';
import '../network/auth_worker.dart';
import '../network/resp_res_enum.dart';

class UserInfoHandler {
  // 选image->裁剪->压缩保存->赋值
  static void prepareAvatar()async {
    StateManagerProv sprov=ProvManager.stateProv;
    String? croppedImgPath=await ImageManager.editImgFromGallery();
    if(croppedImgPath==null){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(ResultCode.IMAGE_ERROR));
      return;
    }
    String? compressedImgPath=await ImageManager.compressAndGetPathDefault(croppedImgPath);
    if(compressedImgPath==null){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(ResultCode.IMAGE_ERROR));
      return;
    }
    sprov.tmpAvatar=compressedImgPath;
  }
  static updateUserInfo({bool isfirst=false}) async {
    StateManagerProv sprov=ProvManager.stateProv;
    DialogHelper.showLoadingDialog(
      userCancel: AuthWorker.cancelRequest
    );
    int code=await UserInfoWorker.updateUserInfo(sprov.tmpUser);
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    if(code!=ResultCode.SUCCESS){
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(code));
      return;
    }
    sprov.updateUser();
    if(isfirst) {
      NavigationHelper.pushReplacementNamed(RouteCollector.main);
      sprov.firstAddInfo = false;
    }
    else{
      NavigationHelper.pop();
    }
  }
}