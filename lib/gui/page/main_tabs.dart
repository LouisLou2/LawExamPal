import 'package:easy_cse/service/provider/page_change_provider.dart';
import 'package:easy_cse/service/provider/provider_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../constant/app_style/app_color.dart';
import '../widget/nested_tab.dart';
import 'home_page.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key? key}) : super(key: key);

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {

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
    PageChangeProvider pprov=ProviderManager.pageChangeProvider;
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: null,
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(), // 禁止滑动
          children: <Widget>[
              TestHome2(),
              Center(child: Text('Files')),
              NestedTabBar('Shared'),
              Center(child: Text('Profile')),
            ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 55.h,maxWidth: 200.w),
            padding: const EdgeInsets.only(top: 0),
            decoration: const BoxDecoration(
              color: AppColors.white1,
              border: Border(
                top: BorderSide(color: AppColors.lightBorderColor, width: 0.7), // 设置顶部边框
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkText1,
                  offset: Offset(0, -2),
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              dividerHeight: 0,
              labelColor: AppColors.iconBlue,
              unselectedLabelColor: AppColors.silenceColor,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
              onTap: (index) {
                pprov.updateIndex(index);
              },
              tabs: <Widget>[
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 3),
                  text: 'Home',
                  icon: Selector<PageChangeProvider, bool>(
                    selector: (context, provider) => provider.currentIndex==0,
                    builder: (context, selec, child) => selec?const Icon(Icons.home,size: 29):const Icon(Icons.home_outlined,size: 29),
                  ),
                ),
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 3),
                  text: 'Practice',
                  icon: Selector<PageChangeProvider, bool>(
                    selector: (context, provider) => provider.currentIndex==1,
                    builder: (context, selec, child) => selec?const Icon(CupertinoIcons.folder_fill,):const Icon(CupertinoIcons.folder),
                  ),
                ),
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 3),
                  text: 'Notes',
                  icon: Selector<PageChangeProvider, bool>(
                    selector: (context, provider) => provider.currentIndex==2,
                    builder: (context, selec, child) => selec?const Icon(CupertinoIcons.person_2_fill,size: 27):const Icon(CupertinoIcons.person_2,size: 27),
                  ),
                ),
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 3),
                  text: 'Profile',
                  icon: Selector<PageChangeProvider, bool>(
                    selector: (context, provider) => provider.currentIndex==3,
                    builder: (context, selec, child) => selec?const Icon(CupertinoIcons.person_fill):const Icon(CupertinoIcons.person),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}