import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/buttons/colored_text_botton.dart';
import 'package:easy_cse/gui/widget/info_display/alert_bar.dart';
import 'package:easy_cse/gui/widget/info_display/summary_card.dart';
import 'package:easy_cse/gui/widget/info_display/text_section.dart';
import 'package:easy_cse/service/knowledge/basic_knowledge.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
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
    required this.answer,
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
          AlertBar(
            message: AppStrings.advertAITutor,
            color: AppColors.purpleBlue.withOpacity(0.8),
            onTap: () => NavigationHelper.pushNamed(RouteCollector.chat),
          ),
          // 这里不包裹Material会使得ListTile沿用父级Container的背景色
          TextSection(title:AppStrings.question, content:widget.question),
          defDivider(),
          TextSection(title:AppStrings.idea, content: widget.idea),
          defDivider(),
          TextSection(title:AppStrings.answer, content: widget.answer),
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
              onTap: ()=>NavigationHelper.pushNamed(RouteCollector.chat),
              tileColor: AppColors.white0,
              leading: const CircleAvatar(
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
                      enabled: false,
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
                    onPressed: ()=>NavigationHelper.pushNamed(RouteCollector.chat),
                    width: 160.w,
                  ),
                ],
              )
            ),
          ),
          defDivider(),
          defAnswerSection(
            title: AppStrings.morePractice,
            child: SummaryCard(
              title: AppStrings.AIChoose,
              points: BasicKnowledge.typicalPoints,
              color: AppColors.purpleBlue,
              action: ColorTextButton(
                text: AppStrings.tryQuestion,
                onPressed: ()=>NavigationHelper.pushNamed(RouteCollector.do_problems),
                color: AppColors.purpleBlue,
              ),
            )
          ),
          SizedBox(height: 110.h,),
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
Widget defAnswerSection({required String title,Widget?child}) {
  return Material(
    child:ListTile(
      tileColor: AppColors.white0,
      title: Padding(
        padding: EdgeInsets.only(bottom:10.h),
        child: Text(
          title,
          style: AppStyles.iconTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkText0,
          ),
        ),
      ),
      subtitle: child,
    ),
  );
}