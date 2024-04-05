import 'package:easy_cse/constant/situation_enum.dart';
import 'package:easy_cse/gui/widget/info_display/answer_display.dart';
import 'package:easy_cse/gui/widget/info_display/show_custom_bottom_sheet.dart';
import 'package:easy_cse/gui/widget/try_again.dart';
import 'package:easy_cse/gui/widget/ui_kitbag.dart';
import 'package:easy_cse/service/handler/content_handler.dart';
import 'package:easy_cse/service/provider/content_provider.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';
import 'dart:io' show File;
import '../../widget/answer_tool_bar.dart';

class ExplanationPage extends StatefulWidget {
  final String imgPath;
  const ExplanationPage({super.key, required this.imgPath});

  @override
  State<StatefulWidget> createState() => _ExplainationPageState();
}
class _ExplainationPageState extends State<ExplanationPage> {
  // 这里又弄了一个内部类，为了防止sheet出错
  final innerWidget = InnerWidget();
  late final ContentProv cprov;
  @override
  void initState() {
    cprov=ProvManager.contentProv;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PersistentBottomSheetController con=await showCustomBottomSheet(
        innerWidget.context,
        height:MediaQuery.of(context).size.height / 1.2,
        child:Expanded(
          child: Selector<ContentProv,int>(
              selector: (_,prov)=>prov.quesSearchState,
              builder: (_,sta,__){
                switch(sta){
                  case UIStateEnum.LOADING: return const Center(
                    child: UIKitBag.blue_loadingIndicator,
                  );
                  case UIStateEnum.FAIL: return TryAgainWidget(
                    onTryAgain: () =>ContentHandler.executeSearchQuesAgain(widget.imgPath),
                  );
                  case UIStateEnum.DONE: return AnswerDisplay(
                    question: cprov.latestQuesRes.ques,
                    idea: cprov.latestQuesRes.idea,
                    answer: cprov.latestQuesRes.ans,
                  );
                  default:
                    return const Text(AppStrings.debugError);
                }
              }
          ),
        ),
        toolBar:const AnswerToolBar(),
      );
      con.closed.then((value) {
        if (kDebugMode) {
          print('@@@@@@@@@@closed');
        }
        Navigator.of(context).pop();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      appBar: AppBar(
        leading: innerWidget,
        title: Text(
          AppStrings.explanation,
          style:AppStyles.iconTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: AppColors.discoBallBlue,
        centerTitle: true,
        toolbarHeight: 50,
      ),
      body: Image.file(
        File(widget.imgPath),
        fit: BoxFit.cover,
      ),
    );
  }
}

class InnerWidget extends StatelessWidget {
  InnerWidget({super.key});
  late BuildContext _context;
  BuildContext get context => _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container();
  }
}