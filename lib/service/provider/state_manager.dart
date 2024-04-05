import 'package:easy_cse/service/repository/db_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entity/persistence_kind/user.dart';

class StateManagerProv extends ChangeNotifier{
  bool canLogin=false;
  late User user;
  late User tmpUser;

  bool firstAddInfo=false;

  Future<void> init() async{
    final nullableUser=await DBHandler.getLastLoginUser();
    if(nullableUser!=null){
      user=nullableUser;
      canLogin=true;
    }
    else{
      user=User.empty();
      // 直接使用canLogin=false值即可，这里不需要再次赋值
    }
  }
  StateManagerProv(){
    // 不能在构造函数中调用等待异步方法完成
  }
  void autoLogin(){
    // 此方法是用户刚刚注册成功后，自动登录的方法, firstAddInfo=true的只会在这里
    firstAddInfo=true;
    canLogin=true;
  }
  void logout(){
    canLogin=false;
    user=User.empty();
  }

  void refreshLoginTime(){
    user.lastLoginTime=DateTime.now();
  }

  void copyUserToTmp(){
    //每次到达个人信息页面时，都会将user的值赋给tmpUser
    tmpUser=user.copyWith();
  }

  void updateUser(){
    if(tmpUser.name!=null&&tmpUser.name!=''){
      user.name=tmpUser.name;
    }
    if(tmpUser.gender!=null&&tmpUser.gender!=null){
      user.gender=tmpUser.gender;
    }
    if(tmpUser.avatar!=null&&tmpUser.avatar!=''){
      user.avatar=tmpUser.avatar;
    }
    if(tmpUser.birthday!=null){
      user.birthday=tmpUser.birthday;
    }
    if(tmpUser.role!=null){
      user.role=tmpUser.role;
    }
    if(tmpUser.goal!=null){
      user.goal=tmpUser.goal;
    }
    notifyListeners();
  }

  // setter for user
  set avatar(String path){
    user.avatar=path;
    notifyListeners();
  }
  set birthday(DateTime? date) {
    user.birthday = date;
    notifyListeners();
  }
  //getter for user
  DateTime? get birthday => user.birthday;

  // setter for tmp
  set tmpAvatar(String path){
    tmpUser.avatar=path;
    notifyListeners();
  }
  set tmpBirthday(DateTime date) {
    tmpUser.birthday = date;
    notifyListeners();
  }
  set tmpName(String name){
    tmpUser.name=name;
  }
  set tmpGender(bool gender){
    tmpUser.gender=gender;
    notifyListeners();
  }
  set tmpRole(int role){
    tmpUser.role=role;
    notifyListeners();
  }
  set tmpGoal(int goal){
    tmpUser.goal=goal;
    notifyListeners();
  }
}