import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/constant/situation_enum.dart';
import 'package:easy_cse/domain/entity/code_desc.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_style.dart';
class ColorGroup{
  final Color backC;
  final Color foreC;
  final Color hoverC;
  const ColorGroup({
    required this.backC,
    required this.foreC,
    required this.hoverC,
  });
}
class SnackbarHelper {
  const SnackbarHelper._();
  static final _key = GlobalKey<ScaffoldMessengerState>();
  static GlobalKey<ScaffoldMessengerState> get key => _key;

  static const Duration errorDuration=Duration(seconds: UIParams.defSnackBarDuration_error);
  static const Duration infoDuration=Duration(seconds: UIParams.defSnackBarDuration_info);

  static ColorGroup getColorGroup(int kind){
    switch(kind){
      case SituationEnum.ERROR:
        return AppStyles.ErrorColorGroup;
      case SituationEnum.INFO:
        return AppStyles.InfoColorGroup;
      case SituationEnum.SUCCESS:
        return AppStyles.SuccessColorGroup;
      default:
        return AppStyles.InfoColorGroup;
    }
  }
  static void showToasterWithDesc(CodeDesc desc){
    showToaster(title: desc.what, message: desc.how, kind: desc.kind);
  }
  static void showToaster({String? title,String? message,int kind=SituationEnum.ERROR,VoidCallback? onPressed, String? actionText}){
    ColorGroup colorGroup=getColorGroup(kind);
    print('colorGroup: $colorGroup');
    _key.currentState
      ?..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(0),
          content: ShadToast(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            backgroundColor: colorGroup.backC,
            title: Text(
              title??AppStrings.somethingWentWrong,
              style: AppStyles.tinyText.copyWith(
                color: colorGroup.foreC,
                fontSize: 16,
              ),
            ),
            description: message==null?null:
            Text(
              message,
              style: AppStyles.tinyText.copyWith(
                color: colorGroup.foreC,
                fontWeight: FontWeight.normal,
              ),
            ),
            action: actionText==null?null:
            ShadButton(
              hoverBackgroundColor: colorGroup.hoverC,
              backgroundColor: colorGroup.backC,
              text: Text(
                actionText,
                style: AppStyles.tinyText.copyWith(
                  color: colorGroup.foreC,
                  fontWeight: FontWeight.normal,
                ),
              ),
              border: Border.all(
                color: colorGroup.foreC,
                width: 1.5,
              ),
              onPressed: onPressed??_key.currentState?.removeCurrentSnackBar,
            ),
          ),
          duration: kind==SituationEnum.ERROR ? errorDuration : infoDuration,
        ),
      );
  }
}