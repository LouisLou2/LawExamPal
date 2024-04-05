import 'package:flutter/material.dart';

import '../../../constant/situation_enum.dart';
import '../../../domain/entity/persistence_kind/ques_history.dart';

class QuesHistoryProv with ChangeNotifier {
  late int _searchHistoryState;
  late List<QuestionHistory>quesHistoryList;
  int nowPage=0;
  bool over=false;
  late bool _showJumpButton;// 是否显示跳至底部的按钮
  late bool _showMoreButton;// 是否显示加载更多的按钮

  QuesHistoryProv(){
    disposeData();
  }

  disposeData(){
    _searchHistoryState=UIStateEnum.LOADING;
    _showMoreButton = false;
    _showJumpButton = false;
    quesHistoryList=[];
    nowPage=0;
    over=false;
  }

  bool get showJumpButton => _showJumpButton;
  bool get showMoreButton => _showMoreButton;
  set showMoreButton(bool value){
    _showMoreButton = value;
    notifyListeners();
  }
  set showJumpButton(bool value){
    _showJumpButton = value;
    notifyListeners();
  }


  // for search history
  int get searchHistoryState => _searchHistoryState;
  void setSearchHistoryLoading(){
    _searchHistoryState=UIStateEnum.LOADING;
    notifyListeners();
  }
  void setSearchHistoryDone(List<QuestionHistory> list){
    //将新查到的数据加入到quesHistoryList中
    _searchHistoryState=UIStateEnum.DONE;
    quesHistoryList.addAll(list);
    notifyListeners();
  }
  void setSearchHistoryFailed(){
    _searchHistoryState=UIStateEnum.FAIL;
    notifyListeners();
  }
}