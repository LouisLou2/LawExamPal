import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortInfoTile extends StatelessWidget {

  final String title;
  final double width;
  final double height;
  final IconData? icon;
  final Color? tileColor;
  final bool? withShadow;
  final double? completePercent;
  final List<String>? tags;
  final VoidCallback? onTap;

  ShortInfoTile({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    this.icon,
    this.tileColor,
    this.withShadow=false,
    this.completePercent,
    this.tags,
    this.onTap,
  }) : super(key: key){
    assert(completePercent==null||completePercent!>=0&&completePercent!<=100);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.fromLTRB(
          width*0.05,
          height*0.07,
          width*0.05,
          height*0.01,
        ),
        decoration: BoxDecoration(
          color: tileColor??AppColors.white0,
          borderRadius: BorderRadius.circular(UIParams.defBorderR),
          boxShadow: withShadow!? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: UIParams.smallBorderR,
              offset: const Offset(1, 1),
            ),
          ]:null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: (height*0.95),
              width: (width*0.68),
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text( title,
                      style: TextStyle(
                        color: AppColors.darkText2,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: height*0.05,),
                    completePercent==null?
                    const SizedBox():Row(
                      children: [
                        Icon(
                          Icons.timelapse,
                          color: AppColors.normalPurple,
                          size: 40.w,
                        ),
                        SizedBox(width: width*0.03,),
                        Text(
                          "Complete - ${completePercent!.toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: AppColors.darkText2,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.06,),
                    tags==null?const SizedBox():Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: tags!.map((tag) => Container(
                        padding: EdgeInsets.symmetric(
                          vertical: height*0.03,
                          horizontal: width*0.02,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(UIParams.tinyBorderR),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: AppColors.normalPurple,
                            fontSize: 24.sp,
                          ),
                        ),
                      )).toList(),
                    ),
                  ]
              ),
            ),
            icon==null?const SizedBox():Icon(
              Icons.rocket_rounded,
              size: width*0.15,
              color: AppColors.orange1,
            ),
          ],
        ),
      ),
    );
  }
}