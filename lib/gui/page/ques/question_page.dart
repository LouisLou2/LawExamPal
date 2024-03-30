import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/domain/entity/question.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_style.dart';
import '../../../service/provider/question_prov.dart';
import '../../widget/buttons/colored_text_botton.dart';

class QuestionDetailPage extends StatefulWidget{
  final int index;
  const QuestionDetailPage({Key? key,required this.index}):super(key:key);
  @override
  State<QuestionDetailPage> createState()=>_QuestionDetailPageState();
}
class _QuestionDetailPageState extends State<QuestionDetailPage>{

  @override
  Widget build(BuildContext context){
    final QuestionProv qprov=ProvManager.questionProv;
    final Question ques=qprov.getQuestion(widget.index);
    return Scaffold(
      backgroundColor: AppColors.white1,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 6.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShadBadge.secondary(
                  text: Text(ques.isChoice?AppStrings.singleChoice:AppStrings.shortAnswer),
                  backgroundColor: AppColors.purpleBlue,
                  foregroundColor: AppColors.white2,
                  hoverBackgroundColor: AppColors.purpleBlue,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            SelectableText(
              ques.question,
              style: AppStyles.bodySmallDark
            ),
            if(ques.isChoice)
            Column(
              children: ques.options!.asMap().entries.map((entry) => ListTile(
                  title: Text(
                    ques.options![entry.key],
                    style: AppStyles.bodySmallDark
                  ),
                  leading: Selector<QuestionProv, int>(
                    selector: (context, prov)=>prov.getUserChoice(widget.index),
                    builder: (context, choice, child)=>getChoiceAvatar(entry.key,choice==entry.key),
                  ),
                  onTap: ()=>qprov.setUserChoice(widget.index,entry.key),
                ),
              ).toList(),
            ),
            SizedBox(height: 20.h),
            ColorTextButton(
              text: AppStrings.viewAnswer,
              onPressed: () {},
              color: AppColors.purpleBlue,
            ),
          ],
        ),
      )
    );
  }
  Widget getChoiceAvatar(int index,bool isSelected){
    return CircleAvatar(
      foregroundColor: isSelected?AppColors.white2:AppColors.darkText0,
      backgroundColor: isSelected?AppColors.purpleBlue:AppColors.white2,
      child: Text(String.fromCharCode(65+index)),
    );
  }
}