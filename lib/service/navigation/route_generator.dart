import 'package:easy_cse/gui/page/main_tabs.dart';
import 'package:easy_cse/gui/page/sign_in_page.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:flutter/material.dart';
import 'package:easy_cse/gui/page/error_page.dart';

import '../../state/user.dart';
class RouteGenerator {

  static MaterialPageRoute<void> getRoute({
    required Widget widget,
    required RouteSettings settings,
    bool fullscreenDialog = false,
  })=>MaterialPageRoute<void>(
    builder: (context) => widget,
    settings: settings,
    fullscreenDialog: fullscreenDialog,
  );

  // 用于根据给定的RouteSettings生成路由。当尝试导航到未定义的命名路由时，将调用此函数来动态生成路由。
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // simpleRoutes中都是注册在路由表中的，不会触发这个方法，specialRoutes中的才会触发这个方法
    // assert (RouteCollector.specialRoutes.contains(settings.name));
    // 对于那些需要用户满足某种条件才能跳转的页面，可以在这里进行判断
    // 这里先不做判断，直接返回错误页面
    print('settings.name: ${settings.name}');
    if(!User.instance.isLoggedIn){
      return getRoute(widget: const SignInPage(), settings: settings);
    }
    // 如果用户已经登录，就跳转到它要去的页面
    if(settings.name == RouteCollector.main){
      return getRoute(widget: const MainTabs(), settings: settings);
    }
    // 这里只处理了main页面，其他页面都返回错误页面(测试阶段)
    return getRoute(widget: const ErrorPage(), settings: settings);
  }
}