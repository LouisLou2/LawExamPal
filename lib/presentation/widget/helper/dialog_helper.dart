import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class DialogHelper{
  const DialogHelper._();
  // 此类不应该被实例化
  static final _key=NavigationHelper.key;

  static bool isDialogShowing=false;
  static BuildContext? dialogContext;

  static const Dialog loadingDialog= Dialog(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: 20, // 指定半径大小
            animating: true,
          ),// 是否执行动画);
          SizedBox(width: 20),
          Text('${AppStrings.loading}...'),
        ],
      ),
    ),
  );

  // show一个dialog会自动dismiss之前的dialog
  static void showLoadingDialog({VoidCallback? userCancel}){
    showDiaglog(dialog: loadingDialog,userCancel: userCancel);
  }
  static void showAskDialog({required String title,String? text, VoidCallback? onYes,VoidCallback? onNo,bool willCloseDialog=true}){
    Dialog askDialog= Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.iconTextStyle,
            ),
            if(text!=null) const SizedBox(height: 10),
            if(text!=null)
            Text(
              text,
              style: AppStyles.bodySmallDark,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: (){
                    if(willCloseDialog){ dismissDialog();}
                    if(onNo!=null){ onNo(); }
                  },
                  child: Text(
                    AppStrings.cancel,
                    style: AppStyles.iconTextStyle.copyWith(color: AppColors.silentBlue),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: (){
                    if(willCloseDialog){ dismissDialog();}
                    if(onYes!=null){ onYes(); }
                  },
                  child: Text(
                    AppStrings.confirm,
                    style: AppStyles.iconTextStyle.copyWith(color: AppColors.thickRed),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    showDiaglog(
      dialog: askDialog,
      userCancel: onNo,// 如果用户点击了返回键，就代表onNo
    );
  }

  static void showDiaglog({required Widget dialog,VoidCallback? userCancel}){
    if(isDialogShowing){
      dismissDialog();
    }
    showDialog(
      barrierDismissible: false, // 点击背景不关闭模态框
      context: _key.currentContext!,
      builder: (context){
        dialogContext=context;
        isDialogShowing=true;
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop){
            if(didPop){
              return;
            }
            isDialogShowing=false;
            Navigator.of(context).pop();
            if(userCancel!=null){
              userCancel();
            }
          },
          child: dialog,
        );
      },
    );
  }
  static void dismissDialog(){
    if(isDialogShowing){
      Navigator.of(dialogContext!).pop();
      isDialogShowing=false;
    }
  }
}