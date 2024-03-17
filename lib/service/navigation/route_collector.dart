import 'package:easy_cse/gui/page/edit_image.dart';
import 'package:easy_cse/gui/page/error_page.dart';
import 'package:easy_cse/gui/page/snap_pic_page.dart';
import 'package:flutter/material.dart';

import '../../gui/page/main_tabs.dart';

class RouteCollector {
  static const String sign_in = '/sign_in';
  static const String sign_up = '/sign_up';
  static const String main = '/main';
  static const String about = '/about';
  static const String snap_pic = '/snap_pic';
  static const String edit_image = '/edit_image';
  static const Set<String> simpleRoutes = {
    sign_in,
    sign_up,
    about,
    snap_pic,
  };

  // specialRoutes中的路由不会在路由表中注册，而是在RouteGenerator中动态生成,因为这些路由需要用户满足某种条件才能跳转
  static const Set<String> specialRoutes = {
    main,
  };
  static Map<String, WidgetBuilder> simpleRouteMap = {
    '/about': (context) => const ErrorPage(),
    '/main': (context) => const MainTabs(),
    '/snap_pic': (context) => const SnapPicPage(),
    '/edit_image': (context) => const HomeScreen(),
    // '/sign_in': (context) => const Center(),
    // '/sign_up': (context) => const SignUpPage(),
  };
}