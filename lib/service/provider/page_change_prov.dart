import 'package:flutter/material.dart';

class PageChangeProv extends ChangeNotifier {
  final List<String> _pages = ['Home', 'Files', 'Shared','Profile'];
  final List<String> _sharedPages = ['Files','Library'];
  int _currentIndex = 0;
  int _teamIndex = 0;
  int get currentIndex => _currentIndex;
  int get teamIndex => _teamIndex;
  String get nowPageName => _pages[_currentIndex];
  String get nowSharedPageName => _sharedPages[_teamIndex];

  PageChangeProv({int currentIndex = 0, int teamIndex = 0}) {
    _currentIndex = currentIndex;
    _teamIndex = teamIndex;
  }
  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  void updateTeamIndex(int index) {
    _teamIndex = index;
    notifyListeners();
  }
}