import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';

class UserInfoProv extends ChangeNotifier{
  User? user;
  void init() {
    user=null;
  }
  set setUser(User user){
    this.user = user;
    notifyListeners();
  }
  set avatar(String avatar){
    assert (user!=null);
    user!.avatar = avatar;
    notifyListeners();
  }
}