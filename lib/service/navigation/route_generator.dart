import 'package:easy_cse/gui/page/explanation_page.dart';
import 'package:easy_cse/gui/page/file_preview.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:flutter/material.dart';
import 'package:easy_cse/gui/page/error_page.dart';

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
    // 这里只处理了main页面，其他页面都返回错误页面(测试阶段)
    switch (settings.name) {
      case RouteCollector.explanation:
        String imgPath = settings.arguments as String;
        return getRoute(widget: ExplanationPage(imgPath: imgPath,), settings: settings);
      case RouteCollector.file_preview:
        return getRoute(widget: const FilePreviewPage(), settings: settings);
      default:
        return getRoute(widget: const ErrorPage(), settings: settings);
    }
  }
}