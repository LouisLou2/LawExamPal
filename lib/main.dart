import 'package:easy_cse/init_affairs.dart';
import 'package:easy_cse/presentation/page/myapp.dart';
import 'package:flutter/material.dart';

void main() async{
  await initMustBeforeRunApp();
  initAsync();
  runApp(const MyApp());
}