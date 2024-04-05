import 'dart:io';

import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget{
  final Widget imgWidget;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? title;
  final String? subTitle;
  const ImageTile({
    super.key,
    this.onTap,
    this.title,
    this.subTitle,
    this.onLongPress,
    required this.imgWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: imgWidget,
      title: title==null?null:Text(
        title!,
        style:AppStyles.bodySmallDark
      ),
      subtitle: subTitle==null?null:Text(
        subTitle!,
        style: AppStyles.tinyText,
      ),
    );
  }
}