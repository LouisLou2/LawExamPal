import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathManager{
  static bool _inited = false;
  static late String _tempPath;
  static const String _picLoc = 'camera_awesome_pic';
  static late String _picPath;
  static final List<String> _picPaths = [];
  static _initTempDir() async{
    final Directory tempDir = await getTemporaryDirectory();
    PathManager._tempPath = tempDir.path;
    _picPath = '$_tempPath/$_picLoc';
    Directory picDir=Directory(_picPath);
    if(!await picDir.exists()){
      await picDir.create(recursive: true);
    }
    _inited = true;
  }
  static init() async {
    _initTempDir();
  }
  static Future<String> makePhotoPath(int sensorPos) async {
    // sensorPos: 0 for back, 1 for front
    if(!_inited) await _initTempDir();
    _picPaths.add('$_picPath/${sensorPos == 0 ? 'back' : 'front'}_${DateTime.now().millisecondsSinceEpoch}.jpg');
    print('@@@@@@@@@@@@@picPaths: ${_picPaths.last}');
    return _picPaths.last;
  }
  static String get lastPicPath => _picPaths.last;
}