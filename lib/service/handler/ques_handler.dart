import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/domain/entity/resp_model/ques_search_res.dart';
import 'package:easy_cse/gui/widget/helper/snackbar_helper.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/global/state_manager.dart';
import 'package:easy_cse/service/provider/ques/question_prov.dart';
import 'package:easy_cse/service/repository/db_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import '../../constant/situation_enum.dart';
import '../../domain/entity/resp_model/recommend_ques.dart';
import '../file_manager/image_manger.dart';
import '../file_manager/path_manager.dart';
import '../navigation/route_collector.dart';
import '../network/ques_worker.dart';
import '../provider/ques/explanation_provider.dart';

class QuesHandler{
  static final ExplanationProv cprov=ProvManager.explanationProv;
  static final StateManagerProv sprov=ProvManager.stateProv;
  static final QuestionProv qprov=ProvManager.questionProv;

  /*搜索题目*/
  static Future<void> executeSearchQues(CaptureRequest req) async{
      String croppedPath=await ImageManager.cropImage(PathManager.lastRawPicPath);
      String? compressedPath=await ImageManager.compressAndGetPathDefault(croppedPath);
      if(compressedPath==null){
        SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(ResultCode.IMAGE_ERROR));
        return;
      }
      // 现在可以先跳到结果页
      cprov.setQuesSearching();
      NavigationHelper.pushNamed(RouteCollector.explanation, arguments: compressedPath);
      String token=sprov.user.token;
      Tuple2<int,QuesSearchRes?> res=await QuesWorker.searchQues(token:token,picPath: compressedPath);

      if(res.item1==ResultCode.SUCCESS){
        cprov.setQuesSearchDone(res.item2!);
        DBHandler.addQuesHistory(
          QuestionHistory(
            userId: sprov.user.id,
            imgPath: compressedPath,
            time: DateTime.now(),
          )
        );
      }else{
        cprov.setQuesSearchFailed();
        SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      }
  }
  /*用于搜题失败后的再次尝试，只能在哪里调用*/
  static Future<void> executeSearchQuesAgain(String compressedPath) async{
    // 仅仅在结果页中使用
    cprov.setQuesSearching();
    String token=sprov.user.token;
    Tuple2<int,QuesSearchRes?> res=await QuesWorker.searchQues(token:token,picPath: compressedPath);
    if(res.item1==ResultCode.SUCCESS){
      cprov.setQuesSearchDone(res.item2!);
    }else{
      cprov.setQuesSearchFailed();
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
    }
  }
  /*用于查看使用quesId进行的查看答案解析的方法: 控制qprov*/
  static Future<void> getRcmdQuesWithQuesId(int index, VoidCallback showSheet)async {
    int quesId=qprov.getQuestion(index).quesId;
    qprov.setQuesPageState(index, UIStateEnum.LOADING);
    showSheet();
    String token=sprov.user.token;
    Tuple2<int,QuesSearchRes?> res=await QuesWorker.searchQuesByQuesId(
        token: token,
        quesId: quesId,
    );
    if(res.item1==ResultCode.SUCCESS){
      qprov.setQuesSearchDone(index, res.item2!);
    }else{
      qprov.setQuesPageState(index, UIStateEnum.FAIL);
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
    }
  }

  /*用于从请求进入相似题目做题界面的一切工作统筹执行*/
  static Future<void> executeGetRecommendQues(QuesSearchRes quesRes)async {
    // 先进去做题界面，设置加载中
    qprov.setPageState=UIStateEnum.LOADING;
    NavigationHelper.pushNamed(RouteCollector.do_questions);
    // 请求题目
    String token=sprov.user.token;
    Tuple2<int,RecommendQues?> res=await QuesWorker.getRecommendQues(
        token:token,
        quesId: quesRes.quesId,
        ques: quesRes.quesId==null?quesRes.ques:null,
    );
    if(res.item1==ResultCode.SUCCESS){
      qprov.setQuestionResourceAndRefresh(res.item2!);
      qprov.setQuesIndex=0;
    }else{
      qprov.setPageState=UIStateEnum.FAIL;
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
    }
  }
  /*用于从请求进入相似题目做题界面的一切工作统筹执行*/
  static Future<void> executeGetRecommendQues_Again(QuesSearchRes quesRes)async {
    // 先进去做题界面，设置加载中
    qprov.setPageState=UIStateEnum.LOADING;
    // 请求题目
    String token=sprov.user.token;
    Tuple2<int,RecommendQues?> res=await QuesWorker.getRecommendQues(
      token:token,
      quesId: quesRes.quesId,
      ques: quesRes.quesId==null?quesRes.ques:null,
    );
    if(res.item1==ResultCode.SUCCESS){
      qprov.setQuestionResourceAndRefresh(res.item2!);
      qprov.setQuesIndex=0;
    }else{
      qprov.setPageState=UIStateEnum.FAIL;
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
    }
  }
}