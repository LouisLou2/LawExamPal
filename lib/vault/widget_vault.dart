import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../constant/app_style/app_color.dart';
import '../gui/widget/color_box.dart';
import '../util/color_util.dart';

Row _taskHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SelectableText(
        "My Task",
        style: TextStyle(
          color: Colors.blueGrey[900],
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        toolbarOptions: const ToolbarOptions(
          copy: true,
          selectAll: true,
        ),
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.blue[400],
          )
      ),
    ],
  );
}