import 'package:flutter/cupertino.dart';

import '../../../domain/entity/resp_model/question.dart';
import '../../../test_data/test_data.dart';

class QuestionProv extends ChangeNotifier {
  late List<Question> quesList;// 总共的题目
  late int quesIndex;// 现在处于第几道
  late List<int> userChoice;// 对于选择题的用户的答案

  void init(){
    quesList = TestData.quesList;
    quesIndex = 0;
    userChoice = List<int>.filled(quesList.length, -1);
  }
  QuestionProv(){
    init();
  }
  set setQuesList(List<Question> list){
    quesList = list;
  }
  set setQuesIndex(int index){
    quesIndex = index;
  }

  get nowQuestion => quesList[quesIndex];

  Question getQuestion(int index){
    return quesList[index];
  }
  int getUserChoice(int index){
    return userChoice[index];
  }
  void setUserChoice(int index,int choice){
    userChoice[index] = choice;
    notifyListeners();
  }
}