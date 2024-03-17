import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/provider/page_change_provider.dart';

class AppBarVault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: ClipOval(
          child: Container(
            height: 30,
            width: 32,
            color: Colors.indigo, // 设置背景色为红色
            child: const Icon(
              CupertinoIcons.bag_fill,
              size: 20, // 设置图标大小
              color: Colors.white, // 设置图标颜色
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(
            Icons.add,
            size: 30,
            weight: 2.0,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: (){},
          icon: const Icon(
            Icons.search,
            size: 27,
            weight: 2.0,
            color: Colors.white,
          ),
        ),
      ],
      title: Selector<PageChangeProvider, int>(
        selector: (context, provider) => provider.currentIndex,
        builder: (context, currentIndex, child)=>const Text(
          "nowPageName",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}