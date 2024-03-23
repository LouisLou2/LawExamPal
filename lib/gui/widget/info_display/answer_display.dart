import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/buttons/colored_text_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_string.dart';

class AnswerDisplay extends StatefulWidget {
  final String question;
  final String idea;
  final String answer;

  const AnswerDisplay({
    Key? key,
    required this.question,
    required this.idea,
    required this.answer
  }) : super(key: key);

  @override
  State<AnswerDisplay> createState() => _AnswerDisplayState();
}

class _AnswerDisplayState extends State<AnswerDisplay> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          // 这里不包裹Material会使得ListTile沿用父级Container的背景色
          Material(
            child:ListTile(
              tileColor: AppColors.white0,
              title: Text(
                AppStrings.question,
                style: AppStyles.iconTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText0,
                ),
              ),
              subtitle: Text(
                widget.question,
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          defDivider(),
          Material(
            child:ListTile(
              tileColor: AppColors.white0,
              title: Text(
                AppStrings.idea,
                style: AppStyles.iconTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText0,
                ),
              ),
              subtitle: Text(
                widget.idea,
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          defDivider(),
          Material(
            child:ListTile(
              tileColor: AppColors.white0,
              title: Text(
                AppStrings.answer,
                style: AppStyles.iconTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkText0,
                ),
              ),
              subtitle: Text(
                widget.answer,
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          defDivider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '   ${AppStrings.askAITutor}',
              style: AppStyles.iconTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkText0,
              ),
            ),
          ),
          Material(
            child:ListTile(
              tileColor: AppColors.white0,
              leading:const CircleAvatar(
                backgroundColor: AppColors.purpleBlue,
                child: Text('✨'),
              ),
              title: Card(
                color: AppColors.white0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 6.h),
                  child: Text(
                    AppStrings.AITutorDescription,
                    style: AppStyles.bodySmall.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 6,
                      cursorColor: AppColors.scentBlue,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        fillColor: AppColors.white1,
                        filled: true,
                        border: OutlineInputBorder( // 设置边框样式
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none, // 边框颜色为透明
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                        hintText: '  Message',
                      ),
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      // 意思是点击外部的时候，让键盘消失
                    ),
                  ),
                  SizedBox(width: 20.w,),
                  ColorTextButton(
                    text: AppStrings.ask,
                    onPressed: (){},
                    width: 160.w,
                  ),
                ],
              )
            ),
          ),
          SizedBox(height: 70.h,)
        ],
      ),
    );
  }
}
Widget defDivider() {
  return Divider(
    color: AppColors.white1,
    height: 26.h,
    thickness: 10.h,
  );
}