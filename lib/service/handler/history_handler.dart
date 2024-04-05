import 'package:easy_cse/constant/app_rule.dart';
import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/ques_history_prov.dart';
import 'package:easy_cse/service/provider/state_manager.dart';
import 'package:easy_cse/service/repository/db_handler.dart';

class HistoryHandler{
  static final QuesHistoryProv qprov=ProvManager.quesHistoryProv;
  static final StateManagerProv sprov=ProvManager.stateProv;

  static Future<void> showQuesSearchHistory() async {
    // 在initState中调用
    qprov.setSearchHistoryLoading();
    List<QuestionHistory> list=await DBHandler.getQuesHistory(sprov.user.id, qprov.nowPage);
    if(list.length<AppRule.historyPageSize){
      qprov.over=true;
    }else{
      ++qprov.nowPage;
    }
    qprov.setSearchHistoryDone(list);
  }
  static Future<void> showQuesSearchHistory_More() async {
    qprov.showMoreButton=false;
    if(qprov.over)return;
    qprov.setSearchHistoryLoading();
    List<QuestionHistory> list=await DBHandler.getQuesHistory(sprov.user.id,qprov.nowPage);
    if(list.length<AppRule.historyPageSize){
      qprov.over=true;
    }else{
      ++qprov.nowPage;
    }
    qprov.setSearchHistoryDone(list);
  }
}