import 'package:easy_cse/gui/widget/info_display/answer_display.dart';
import 'package:easy_cse/gui/widget/info_display/show_custom_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_style.dart';
import 'dart:io' show File;

import '../../../test_data/test_data.dart';
import '../../widget/answer_tool_bar.dart';

class ExplanationPage extends StatefulWidget {
  final String imgPath;
  const ExplanationPage({Key? key, required this.imgPath}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExplainationPageState();
}
class _ExplainationPageState extends State<ExplanationPage> {
  // 这里又
  final innerWidget = InnerWidget();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      PersistentBottomSheetController con=await showCustomBottomSheet(
        innerWidget.context,
        height:MediaQuery.of(context).size.height / 1.2,
        child:const DefaultTabController(
          length: 2,
          child: Expanded(
            child: AnswerDisplay(
              question: TestData.quesDetail,
              idea: TestData.idea,
              answer: TestData.ans,
            ),
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
  InnerWidget({Key? key}) : super(key: key);
  late BuildContext _context;
  BuildContext get context => _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container();
  }
}