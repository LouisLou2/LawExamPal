import 'package:flutter/material.dart';

class UserInfoProv extends ChangeNotifier{
  late int _userId;
  late String _userName;
  late String _userAvatar;
  late String _userEmail;
  late String _userPhone;
  late String _userGender;
  late String _userSignature;
  late String _userRole;
  late String _userToken;

  late bool _isLogin;
  late bool _isFirst;
  void init(){
    _userId = 0;
    _userName = '';
    _userAvatar = '';
    _userEmail = '';
    _userPhone = '';
    _userGender = '';
    _userSignature = '';
    _userRole = '';
    _userToken = '';
    _isLogin = false;
    _isFirst = true;
  }
  // setters and getters
  int get userId => _userId;
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;
  String get userGender => _userGender;
  String get userSignature => _userSignature;
  String get userRole => _userRole;
  String get userToken => _userToken;
  bool get isLogin => _isLogin;
  bool get isFirst => _isFirst;
  set userId(int value) {
    _userId = value;
    notifyListeners();
  }
  set userName(String value) {
    _userName = value;
    notifyListeners();
  }
  set userAvatar(String value) {
    _userAvatar = value;
    notifyListeners();
  }
  set userEmail(String value) {
    _userEmail = value;
    notifyListeners();
  }
  set userPhone(String value) {
    _userPhone = value;
    notifyListeners();
  }
  set userGender(String value) {
    _userGender = value;
    notifyListeners();
  }
  set userSignature(String value) {
    _userSignature = value;
    notifyListeners();
  }
  set userRole(String value) {
    _userRole = value;
    notifyListeners();
  }
  set userToken(String value) {
    _userToken = value;
    notifyListeners();
  }
  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
  set isFirst(bool value) {
    _isFirst = value;
    notifyListeners();
  }
  void clear(){
    _userId = 0;
    _userName = '';
    _userAvatar = '';
    _userEmail = '';
    _userPhone = '';
    _userGender = '';
    _userSignature = '';
    _userRole = '';
    _userToken = '';
    _isLogin = false;
    _isFirst = true;
    notifyListeners();
  }
}