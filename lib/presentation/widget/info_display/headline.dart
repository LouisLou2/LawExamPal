import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';

class HeadLine extends StatelessWidget {
  final String title;
  final double size;
  final String? subTitle;
  final IconData? iconData;
  final String? iconText;
  final double? iconSize;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isItalic;
  HeadLine({
    Key? key,
    required this.title,
    required this.size,
    this.subTitle,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.onTap,
    this.isItalic=false, this.iconText,
  }) : super(key: key){
    assert(iconData==null||iconText==null);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: TextStyle(
                fontFamily: AppStyles.defFontFamily,
                fontSize: size,
                fontWeight: FontWeight.w700,
                color: AppColors.darkText0,
                fontStyle: isItalic?FontStyle.italic:FontStyle.normal,
              ),
            ),
            if(subTitle!=null)
            Text( subTitle!,
              style: TextStyle(
                fontSize: size*0.5,
                fontFamily: AppStyles.defFontFamily,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText1,
                fontStyle: isItalic?FontStyle.italic:FontStyle.normal,
              ),
            ),
          ],
        ),
        if(iconData!=null||iconText!=null)
          if(iconData!=null)
            InkWell(
              onTap: onTap,
              child: Icon(
                iconData,
                size: iconSize??UIParams.defIconS,
                color: iconColor??AppColors.iconBlue,
              ),
            )
          else InkWell(
            onTap: onTap,
            child: Text(
              iconText!,
              style: TextStyle(
                fontSize: iconSize??UIParams.defIconS,
                color: iconColor??AppColors.iconBlue,
            ),
          ),
        ),
      ],
    );
  }
}