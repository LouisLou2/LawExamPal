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



class OnGoingTask extends StatelessWidget {
  const OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Startup Website Design with Responsive",
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "10:00 AM - 12:30PM",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Complete - 80%",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          Icon(
            Icons.rocket_rounded,
            size: 60.w,
            color: AppColors.orange1,
          )
        ],
      ),
    );
  }
}