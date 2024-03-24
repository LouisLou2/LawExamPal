import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget{
  final String? imagePath;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? title;
  final String? subTitle;
  const ImageTile({
    super.key,
    this.imagePath,
    this.onTap,
    this.title,
    this.subTitle,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: imagePath==null?null:Image.asset(imagePath!),
      title: title==null?null:Text(title!),
      subtitle: subTitle==null?null:Text(subTitle!),
    );
  }
}