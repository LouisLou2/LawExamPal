import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class HeadLine2 extends StatelessWidget {
  final String title;
  final double size;
  final String? subTitle;
  final IconData? iconData;
  final String? iconText;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isItalic;

  HeadLine2({
    Key? key,
    required this.title,
    required this.size,
    this.subTitle,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.onTap,
    this.isItalic = false, this.iconText,
  }) : super(key: key) {
    assert(iconData == null || iconText == null);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title,
        style: TextStyle(
          fontFamily: AppStyles.defFontFamily,
          fontSize: size,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText0,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        ),
      ),
      subtitle: subTitle != null ? Text(subTitle!,
        style: TextStyle(
          fontSize: size * 0.5,
          fontFamily: AppStyles.defFontFamily,
          fontWeight: FontWeight.w500,
          color: AppColors.darkText1,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        ),
      ) : null,
      trailing: iconData == null && iconText == null ? null :
      iconData != null ?
      InkWell(
        onTap: onTap,
        child: Icon(
          iconData,
          size: iconSize ?? UIParams.defIconS,
          color: iconColor ?? AppColors.iconBlue,
        ),
      ) :
      TextButton(
        onPressed: null,
        style: AppStyles.defButtonStyle(color: AppColors.purpleBlue, height: 40, width: 90),
        child: Text(
          iconText!,
          style: TextStyle(
            fontSize: iconSize ?? UIParams.defTextSize,
            color: iconColor ?? AppColors.white0,
          ),
        ),
      ),
    );
  }
}
