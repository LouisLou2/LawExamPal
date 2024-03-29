import 'package:flutter/cupertino.dart';

import '../../domain/entity/question.dart';
import '../../test_data/test_data.dart';

class QuestionProv extends ChangeNotifier {
  late List<Question> quesList;
  late int quesIndex;
  late List<int> userChoice;
  void init(){
    quesList = [
      Question.fromJson(TestData.ques1),
      Question.fromJson(TestData.ques2),
    ];
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