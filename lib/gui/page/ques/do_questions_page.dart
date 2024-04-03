import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/gui/page/ques/question_page.dart';
import 'package:easy_cse/util/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../widget/decorations/color_bar.dart';

class DoQuestionPage extends StatefulWidget{
  const DoQuestionPage({Key? key}):super(key:key);
  @override
  State<DoQuestionPage> createState()=>_DoQuestionPageState();
}
class _DoQuestionPageState extends State<DoQuestionPage>{
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0,
  );
  final problemTheme='言语理解与表达';
  final problemCount=10;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.xmark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.doProblems,
          style: AppStyles.iconTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.all_inbox),
            onPressed: showAllQuesSheet,
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.bookmark),
            onPressed: (){},
          ),
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: (){},
          ),
        ],
        toolbarHeight: 26.h,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppStrings.problemTheme}($problemTheme)',
                  style: AppStyles.tinyText,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('3',
                      style: AppStyles.iconTextStyle,
                    ),
                    Text('/$problemCount',
                      style: AppStyles.tinyText.copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible( // 使用 Expanded 包裹 PageView.custom
            child: PageView.custom(
              controller: _pageController,
              childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return QuestionDetailPage(index: index);
                },
                childCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void showAllQuesSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context)=>Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h,bottom: 10.h),
          child: ColorBar(
            width: context.widthFraction(fraction: 0.143),
            height: 5,
            radius: 20,
            color: AppColors.darkText1,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          height: 200.h,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (context,index)=>TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.purpleBlue),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIParams.defBorderR))),
              ),
              onPressed: (){
                Navigator.of(context).pop();
                _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
              },
              child:Text(
                '${index+1}',
                style: AppStyles.iconTextStyle.copyWith(color: AppColors.white0),
              ),
            ),
            itemCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
