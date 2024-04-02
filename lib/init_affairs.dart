import 'package:easy_cse/config/test_device.dart';
import 'package:easy_cse/service/file_manager/path_manager.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> initAsync() async{
  // 保证Flutter绑定机制已经初始化
  WidgetsFlutterBinding.ensureInitialized();
  generalUIInit();
  PathManager.init();
}
void initMustBeforeRunApp(){
  ProvManager.init();
  TestDeviceCollection.init();
  StateManager.init();
}
void generalUIInit(){
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}