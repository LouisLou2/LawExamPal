import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:flutter/material.dart';

import '../../constant/situation_enum.dart';
import '../../domain/entity/ques_search_res.dart';

class ContentProv extends ChangeNotifier {


  ContentProv() {
    _quesSearchState=UIStateEnum.LOADING;
  }

  /* 对于各个界面是否加载中的标志
  * 一些handler是使用LoadingDialog来显示加载中的
  * 但是对于一些页面，需要在页面上显示加载中的状态
  * */
  late QuesSearchRes latestQuesRes;
  late int _quesSearchState;

  // for search ques
  int get quesSearchState => _quesSearchState;
  void setQuesSearching(){
    _quesSearchState=UIStateEnum.LOADING;
    notifyListeners();
  }
  void setQuesSearchDone(QuesSearchRes res) {
    _quesSearchState=UIStateEnum.DONE;
    latestQuesRes = res;
    notifyListeners();
  }
  void setQuesSearchFailed(){
    _quesSearchState=UIStateEnum.FAIL;
    notifyListeners();
  }

}