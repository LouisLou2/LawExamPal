import 'package:easy_cse/constant/situation_enum.dart';
import 'package:easy_cse/domain/entity/resp_model/recommend_ques.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entity/resp_model/ques_search_res.dart';
import '../../../domain/entity/resp_model/question.dart';

class QuestionProv extends ChangeNotifier {
  late int pageState;
  late List<int> quesPageStates;
  String? topic;
  late List<Question> quesList;// 总共的题目
  late int quesIndex;// 现在处于第几道
  late List<int> userChoice;// 对于选择题的用户的答案

  late List<QuesSearchRes?> searchResList;// 这些推荐题目的搜索结果，null表示未搜索

  void init(){
    topic = null;
    quesList = [];
    userChoice = [];
    searchResList = [];
    quesIndex = 0;
    pageState=UIStateEnum.DONE;
  }
  QuestionProv(){
    init();
  }
  void disposeData(){
    topic = null;
    pageState=UIStateEnum.DONE;
    quesList.clear();
    userChoice.clear();
    searchResList.clear();
    quesIndex = 0;
  }

  get nowQuestion => quesList[quesIndex];

  Question getQuestion(int index){
    return quesList[index];
  }
  int getUserChoice(int index){
    return userChoice[index];
  }
  set setPageState(int state){
    pageState = state;
    notifyListeners();
  }
  set _setQuesList(List<Question> list){
    quesList = list;
    notifyListeners();
  }
  void setQuestionResourceAndRefresh(RecommendQues ques){
    topic = ques.topic;
    quesList = ques.quesList;
    userChoice = List<int>.filled(quesList.length, -1);// -1表示未选择
    quesPageStates = List<int>.filled(quesList.length, UIStateEnum.DONE);// 每道题的状态
    searchResList = List<QuesSearchRes?>.filled(quesList.length, null);
    pageState = UIStateEnum.DONE;
    notifyListeners();
  }
  set setQuesIndex(int index){
    quesIndex = index;
    notifyListeners();
  }
  void setUserChoice(int index,int choice){
    userChoice[index] = choice;
    notifyListeners();
  }
  void setSearchRes(int index,QuesSearchRes res){
    searchResList[index] = res;
    notifyListeners();
  }
  void setQuesPageState(int index,int state){
    quesPageStates[index] = state;
    notifyListeners();
  }
  void setQuesSearchDone(int index,QuesSearchRes res){
    searchResList[index] = res;
    quesPageStates[index] = UIStateEnum.DONE;
    notifyListeners();
  }
}