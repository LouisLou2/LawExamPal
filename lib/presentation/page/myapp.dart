import 'package:easy_cse/config/test_device.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:easy_cse/service/navigation/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../service/provider/prov_manager.dart';
import '../widget/helper/snackbar_helper.dart';
import 'main_tabs.dart';
import 'onboarding.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TestDevice device = TestDeviceCollection.mobile;
    // 这里先把provider放在顶层，后面再考虑是否可以放在更低的层级
    return MultiProvider(
      providers: ProvManager.getProvList,
      child: ScreenUtilInit(
        designSize: Size(device.dp1, device.dp2),
        minTextAdapt: false,
        splitScreenMode: true,
        child: ShadApp.material(
          home: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: RouteCollector.simpleRouteMap,
            //initialRoute: RouteCollector.main, // 这里如果使用initialRoute，会在home的基础上再跳转一次。
            navigatorKey: NavigationHelper.key,
            scaffoldMessengerKey: SnackbarHelper.key,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: Scaffold(
              body: _buildHome(),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildHome() {
    if(ProvManager.stateProv.canLogin){
      return const MainTabs();
    }
    return const OnBoardingPage();
    //return const MainTabs();
    //return const OnBoardingPage();
    //return const ProfilePage();
    //return const EditAccountScreen();
    //return DoQuestionPage();
  }
}