import 'package:flutter/material.dart';

class CustomizeFloatingLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation baseLocation;
  double offsetX;
  double offsetY;
  CustomizeFloatingLocation({required this.baseLocation, this.offsetX=0, this.offsetY=0});
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = baseLocation.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}