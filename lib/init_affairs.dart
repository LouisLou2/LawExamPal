import 'package:easy_cse/config/test_device.dart';
import 'package:easy_cse/service/file_manager/path_manager.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/repository/db_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> initAsync() async{
  generalUIInit();
  /*此方法需要在WidgetsFlutterBinding.ensureInitialized()之后调用，
  但是initAsync()方法是在initMustBeforeRunApp()之后调用的，所以不用再次
  调用WidgetsFlutterBinding.ensureInitialized()方法
  */
}
Future<void> initMustBeforeRunApp() async {
  TestDeviceCollection.init();
  WidgetsFlutterBinding.ensureInitialized();
  await PathManager.init();// 在WidgetsFlutterBinding.ensureInitialized();之后调用
  await DBHandler.init();// 在PathManager.init()之后调用
  ProvManager.init();
  await ProvManager.stateProv.init();// 在DBHandler.init()和ProvManager.init();之后调用
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