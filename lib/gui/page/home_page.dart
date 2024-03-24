import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/gui/widget/info_display/color_box.dart';
import 'package:easy_cse/gui/widget/decorations/decorated_avatar.dart';
import 'package:easy_cse/gui/widget/info_display/headline.dart';
import 'package:easy_cse/gui/widget/info_display/short_info_tile.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:easy_cse/util/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constant/app_string.dart';
import '../../constant/app_style/app_color.dart';
import '../widget/circle_gradient_icon.dart';
import '../widget/info_display/headline2.dart';


class TestHome2 extends StatefulWidget{
  const TestHome2({Key?key}):super(key:key);
  @override
  State<TestHome2> createState()=>_TestHomeState();
}
class _TestHomeState extends State<TestHome2>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      extendBody: false,// 还没有弄清楚这个属性的作用
      // 这个drawer还没有想到要弄成什么方法
      drawer: _buildDrawer(context),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.h),
        child: AppBar(
          backgroundColor: AppColors.white1,
          elevation: 0,// 去掉appbar的阴影
          surfaceTintColor: Colors.transparent,// 保证上划时，tint透明
          automaticallyImplyLeading: false,
          leading:null,
          title: Padding(
            padding: EdgeInsets.only(left: 0,right: 10.h),
            child: DecoratedAvatar(
              image: "assets/images/avatar1.png",
              radius: (UIParams.defSmallAvatarR).h,
              onTap: ()=>NavigationHelper.pushNamed("/sign_in"),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.w,vertical: 8.h),
              child: const Icon(
                Icons.notifications_active_outlined,
                size: UIParams.defIconS,
                color: AppColors.black0,
              ),
            )
          ],
        ),
      ),
      body: _buildBody(),
    );
  }
  Stack _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 0.5.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadLine2(
                  title: AppStrings.answerTitle,
                  size: 70.sp,
                  subTitle: AppStrings.shortDescAI,
                ),
                SizedBox(height: 5.h,),
                buildGrid(),
                SizedBox(height: 25.h,),
                HeadLine(
                  title: AppStrings.hitTopics,
                  size: 50.sp,
                ),
                SizedBox(height: 10.h,),
                _buildTopics(),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          // left: 100.w / 2 - (70 / 2),
          right: 30,
          child: CircleGradientIcon(
            color: Colors.pink,
            onTap: () {},
            size: 60,
            iconSize: 30,
            icon: Icons.add,
          ),
        )
      ],
    );
  }

  Widget _buildDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Digital Literacy'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Imagination'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Critical Thinking'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Communication'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2, // 确定该磁贴在交叉轴上(通常是水平方向)应该占据多少列
      mainAxisSpacing: 15,// 主轴（通常是垂直方向）上子项之间的间距
      crossAxisSpacing: 15,// 交叉轴（通常是垂直方向）上子项之间的间距
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1, //占据列宽
          mainAxisCellCount: 1.3, //占据行高
          child: ColorBox(
            size: 100.w,
            color: AppColors.iconPink,
            icon: CupertinoIcons.camera,
            title: "Snap to Solve",
            spec: "snap a photo to ask questions",
            onTap: ()=>NavigationHelper.pushNamed(RouteCollector.snap_pic),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ColorBox(
            size: (100/1.3).w,
            color: Colors.orange,
            icon: Icons.history_rounded,
            title: "History",
            spec: "history questions",
            onTap: null,
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: ColorBox(
            size: 100.w,
            color: AppColors.basicGreen,
            icon: Icons.article,
            title: "Review",
            spec: "review articles",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: ColorBox(
            size: (100/1.3).w,
            color: MaterialColorGenerator.from(Colors.blue),
            icon: Icons.school,
            title: "AI Tutor",
            spec: "AI powered tutoring",
            onTap: ()=>NavigationHelper.pushNamed(RouteCollector.chat),
          ),
        ),
      ],
    );
  }

  Widget _buildTopics() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.w),
              child: Column(
                children:[
                  ShortInfoTile(
                    title: "How To Write A Good Essay And Get A Good Grade",
                    tags: const ["AI", "Tutor", "Learning"],
                    icon: Icons.school,
                    width: 900.w,
                    height: 300.w,
                    withShadow: true,
                    completePercent: 80,
                  ),
                  SizedBox(height: 10.h,),
                ]
              )
          );
        },
      ),
    );
  }
}