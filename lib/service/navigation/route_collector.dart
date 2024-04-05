import 'package:easy_cse/gui/page/explanation/chat_page.dart';
import 'package:easy_cse/gui/page/onboarding.dart';
import 'package:easy_cse/gui/page/ques/do_questions_page.dart';
import 'package:easy_cse/gui/page/error/error_page.dart';
import 'package:easy_cse/gui/page/explanation/explanation_page.dart';
import 'package:easy_cse/gui/page/ques/ques_history_page.dart';
import 'package:easy_cse/gui/page/user/edit_account_page.dart';
import 'package:easy_cse/gui/page/user/enter_veri_code_page.dart';
import 'package:easy_cse/gui/page/user/sign_in_page.dart';
import 'package:easy_cse/gui/page/explanation/snap_pic_page.dart';
import 'package:flutter/material.dart';

import '../../gui/page/main_tabs.dart';
import '../../gui/page/user/profile_page.dart';
import '../../gui/page/user/sign_up_page.dart';
import '../../gui/page/user/veripage.dart';

class RouteCollector {
  static const String onboarding = '/onboarding';
  static const String sign_in = '/sign_in';
  static const String sign_up = '/sign_up';
  static const String profile = '/profile';
  static const String edit_profile = '/edit_profile';
  static const String enter_veriCode = '/enter_veriCode';
  static const String main = '/main';
  static const String about = '/about';
  static const String snap_pic = '/snap_pic';
  static const String ques_history = '/ques_history';
  static const String chat = '/chat';
  static const String explanation = '/explanation';
  static const String file_preview = '/file_preview';
  static const String do_problems = '/do_problems';
  static const Set<String> simpleRoutes = {
    onboarding,
    sign_in,
    sign_up,
    profile,
    edit_profile,
    about,
    snap_pic,
    ques_history,
    chat,
    do_problems,
    enter_veriCode,
  };

  // specialRoutes中的路由不会在路由表中注册，而是在RouteGenerator中动态生成,因为这些路由需要用户满足某种条件才能跳转
  static const Set<String> specialRoutes = {
    explanation,// 需要传递参数
    file_preview,
  };
  static Map<String, WidgetBuilder> simpleRouteMap = {
    onboarding: (context) => const OnBoardingPage(),
    about: (context) => const ErrorPage(),
    main: (context) => const MainTabs(),
    snap_pic: (context) => const SnapPicPage(),
    ques_history: (context) => const QuesHistoryPage(),
    chat: (context) => const ChatPage(),
    sign_in: (context) => const SignInPage(),
    sign_up: (context) => const SignUpPage(),
    edit_profile: (context) => const EditAccountPage(),
    profile: (context) => const ProfilePage(),
    enter_veriCode: (context) =>const EnterVeriCodePage(),
    do_problems: (context) => const DoQuestionPage(),
  };
}