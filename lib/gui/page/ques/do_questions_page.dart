import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/constant/app_style/ui_fitter.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/gui/page/ques/question_page.dart';
import 'package:easy_cse/gui/widget/ui_kitbag.dart';
import 'package:easy_cse/service/provider/ques/question_prov.dart';
import 'package:easy_cse/util/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/situation_enum.dart';
import '../../../service/handler/ques_handler.dart';
import '../../../service/provider/prov_manager.dart';
import '../../../service/provider/ques/explanation_provider.dart';
import '../../widget/decorations/color_bar.dart';
import '../../widget/try_again.dart';

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
  final ExplanationProv eprov=ProvManager.explanationProv;
  final QuestionProv qprov=ProvManager.questionProv;

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
      body: Selector<QuestionProv,int>(
        selector: (context,prov)=>prov.pageState,
        builder: (context,sta,child) {
          switch(sta){
            case UIStateEnum.LOADING: return const Center(
              child: UIKitBag.blue_loadingIndicator,
            );
            case UIStateEnum.FAIL: return TryAgainWidget(
              onTryAgain: () =>QuesHandler.executeGetRecommendQues_Again(eprov.latestQuesRes),
            );
            case UIStateEnum.DONE: return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppStrings.problemTheme}(${qprov.topic ?? ''})',
                          style: AppStyles.tinyText,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Selector<QuestionProv,int>(
                              selector: (context,prov)=>prov.quesIndex,
                              builder: (context,index,child)=>Text('${index+1}',
                                style: AppStyles.iconTextStyle,
                              ),
                            ),
                            Text('/${qprov.quesList.length}',
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
                        childCount: 4,
                      ),
                    ),
                  ),
                ],
              );
            default:
              return const Text(AppStrings.debugError);
          }
        },
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
          child: Selector<QuestionProv,int>(
              selector: (context,prov)=>prov.quesList.length,
              builder: (context,len,child)=>GridView.builder(
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
                    _pageController.animateToPage(index, duration: UIFitter.pageAnimDuration, curve: Curves.bounceIn);
                  },
                  child:Text(
                    '${index+1}',
                    style: AppStyles.iconTextStyle.copyWith(color: AppColors.white0),
                  ),
                ),
                itemCount: len,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
