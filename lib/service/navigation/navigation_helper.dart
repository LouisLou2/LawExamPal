import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:flutter/material.dart';

class NavigationHelper{
  const NavigationHelper._();
  // 此类不应该被实例化
  static final _key=GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get key=>_key;
  
  static Future<T?>? pushNamed<T extends Object>(String routeName,{Object? arguments,}){
    return _key.currentState?.pushNamed<T?>(
      routeName,
      arguments: arguments,
    );
  }
  static Future<T?>? pushReplacementNamed<T extends Object>(String routeName,{Object? arguments,}){
    return _key.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
  static void pop<T extends Object?>([T? result]){
    return _key.currentState?.pop(result);
  }
  static Future<Object?>? popAllAndPushNamed(String routeName){
    return _key.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
  static Future<Object?>? popAllAndBoard(){
    return popAllAndPushNamed(RouteCollector.onboarding,);
  }
}