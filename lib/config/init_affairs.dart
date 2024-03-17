import 'package:easy_cse/config/test_device.dart';
import 'package:easy_cse/service/path_manager.dart';
import 'package:easy_cse/service/provider/provider_manager.dart';
import 'package:flutter/material.dart';

Future<void> initAsync() async{
  // 保证Flutter绑定机制已经初始化
  WidgetsFlutterBinding.ensureInitialized();
  PathManager.init();
}
void initMustBeforeRunApp(){
  ProviderManager.init();
  TestDeviceCollection.init();
}