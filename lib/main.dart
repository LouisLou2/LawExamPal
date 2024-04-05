import 'package:easy_cse/init_affairs.dart';
import 'package:flutter/material.dart';

import 'gui/page/myapp.dart';

/// Flutter code sample for [TabBar].

void main() async{
  await initMustBeforeRunApp();
  initAsync();
  runApp(const MyApp());
}