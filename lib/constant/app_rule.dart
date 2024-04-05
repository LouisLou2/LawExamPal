class AppRule{
  static const String invalidChar = 'a';
  static bool isCharValid(String char){
    return char!=invalidChar;
  }
  static const int threshold = 10;
  static const veriCodeLength = 6;
  static const historyPageSize = 10;
  static const chatPageSize = 10;
  static const notePageSize = 10;
  static const loadMoreEdge=10;
  static const jumpTime=500;
}