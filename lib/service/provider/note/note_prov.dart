import 'package:flutter/material.dart';

import '../../../constant/situation_enum.dart';
import '../../../domain/entity/persistence_kind/note.dart';
import '../../../domain/entity/persistence_kind/ques_history.dart';

class NoteProv with ChangeNotifier {

  // for note list
  late int _noteState;
  late List<Note>noteList;
  int nowPage=0;
  bool over=false;
  // for file preview
  late int _notePreviewState;
  String? filePath;

  NoteProv(){
    disposeData_list();
  }

  void disposeData_list(){
    _noteState=UIStateEnum.LOADING;
    noteList=[];
    nowPage=0;
    over=false;
  }

  void disposeData_preview(){
    _notePreviewState=UIStateEnum.LOADING;
    filePath=null;
  }

  // for search history
  int get noteState => _noteState;
  void setNoteLoading(){
    _noteState=UIStateEnum.LOADING;
    notifyListeners();
  }
  void addNoteDone(List<Note> list){
    //将新查到的数据加入到quesHistoryList中
    _noteState=UIStateEnum.DONE;
    noteList.addAll(list);
    notifyListeners();
  }
  void setNoteDone(List<Note> list){
    _noteState=UIStateEnum.DONE;
    noteList=list;
    notifyListeners();
  }
  void setNoteFailed(){
    _noteState=UIStateEnum.FAIL;
    notifyListeners();
  }


  // for file preview
  int get notePreviewState => _notePreviewState;
  void setNotePreviewLoading(){
    _notePreviewState=UIStateEnum.LOADING;
    notifyListeners();
  }
  void setNotePreviewDone(String path){
    _notePreviewState=UIStateEnum.DONE;
    filePath=path;
    notifyListeners();
  }
  void setNotePreviewFailed(){
    _notePreviewState=UIStateEnum.FAIL;
    notifyListeners();
  }
}