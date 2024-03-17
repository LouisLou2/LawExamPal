import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  // late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: const TabBar(
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
            tabs: <Widget>[
              Tab(text: 'Files'),
              Tab(text: 'Library'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(5.0),
              child: Center(child: Text('Overview tab')),
            ),
            Card(
              margin: EdgeInsets.all(5.0),
              child: Center(child: Text('Specifications tab')),
            ),
          ],
        ),
      ),
    );
  }
}
