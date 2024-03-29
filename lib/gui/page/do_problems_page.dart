import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/page/problem_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../constant/app_string.dart';
import '../../constant/app_style/app_color.dart';

class DoProblemsPage extends StatefulWidget{
  const DoProblemsPage({Key? key}):super(key:key);
  @override
  State<DoProblemsPage> createState()=>_DoProblemsPageState();
}
class _DoProblemsPageState extends State<DoProblemsPage>{
  final _pageController = PageController(
    initialPage: 2,
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
          style: AppStyles.iconTextStyle.copyWith(color: AppColors.darkText1),
        ),
        centerTitle: true,
        actions: [
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
                  style: AppStyles.microText,
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
          Expanded( // 使用 Expanded 包裹 PageView.custom
            child: PageView.custom(
              controller: _pageController,
              childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return ProblemDetailPage(index: index);
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
