import 'dart:io';

import 'package:easy_cse/constant/app_properties.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entity/persistence_kind/user.dart';

class PathManager{
  static bool _inited = false;

  static late Directory _tempDir;//全平台都有的临时目录(非必要不用)---用于存放临时文件

  static late Directory _appSupportDir;//全平台都有的应用支持目录---数据库文件

  static late Directory _docDir;//全平台都有的文档目录---note文件, 拍题压缩后的图片, 以及用户头像

  static late Directory _cacheDir;//全平台都有的缓存目录---存储拍照搜题未压缩的图片

  static String rawPic= 'rawPic';
  static String compressImg= 'compressImg';
  static String note= 'note';
  static String db= 'db';
  static String avatar= 'avatar';

  static late Directory rawPicDir;//存储为处理前的图片
  static late Directory compressImgDir;//存储为处理后的图片
  static late Directory noteDir;//存储笔记文件
  static late Directory dbDir;//存储数据库文件
  static late Directory avatarDir;//存储用户头像


  static _initPath() async{
    // 获取这四个目录之间没有先后依赖关系
    final List<Future> futures = [
      getTemporaryDirectory(),
      getApplicationSupportDirectory(),
      getApplicationDocumentsDirectory(),
      getTemporaryDirectory()
    ];

    final List<dynamic> results = await Future.wait(futures);

    _tempDir = results[0];
    _appSupportDir = results[1];
    _docDir = results[2];
    _cacheDir = results[3];

    rawPicDir = Directory('${_cacheDir.path}/${AppProperties.appName}/$rawPic');
    compressImgDir = Directory('${_docDir.path}/${AppProperties.appName}/$compressImg');
    noteDir = Directory('${_docDir.path}/${AppProperties.appName}/$note');
    dbDir = Directory('${_appSupportDir.path}/${AppProperties.appName}/$db');
    avatarDir = Directory('${_docDir.path}/${AppProperties.appName}/$avatar');

    //不存在的话，就递归创建
    if(!await rawPicDir.exists()){
      await rawPicDir.create(recursive: true);
    }
    if(!await compressImgDir.exists()){
      await compressImgDir.create(recursive: true);
    }
    if(!await noteDir.exists()){
      await noteDir.create(recursive: true);
    }
    if(!await dbDir.exists()){
      await dbDir.create(recursive: true);
    }
    if(!await avatarDir.exists()){
      await avatarDir.create(recursive: true);
    }
  }

  static init()async{
    await _initPath();
    _inited = true;
  }

  static late String lastRawPicPath;// 最后一次拍照的图片路径，这个会频繁被用到

  static Future<String> makePhotoPath(int sensorPos) async {
    // sensorPos: 0 for back, 1 for front
    lastRawPicPath='${rawPicDir.path}/${sensorPos == 0 ? 'back' : 'front'}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    return lastRawPicPath;
  }

  static Future<String> makeCompressImgPath() async {
    return '${compressImgDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  static String makeDefaultNotePath(User user) {
    return '${noteDir.path}/${user.email}/${DateTime.now().millisecondsSinceEpoch}.pdf';
  }
}