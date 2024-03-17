import 'package:flutter/material.dart';

class NamedDivider extends StatelessWidget {
  final String name;
  final double height;
  final double dividerHeight;
  final double width;
  final double margin;
  final Color dividerColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const NamedDivider({super.key,
    required this.name,
    this.height = 1,
    this.width = 0,
    this.dividerColor = Colors.grey,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.margin=10.0,
    required this.dividerHeight,
    this.textColor=Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: Divider(
                color: dividerColor,
                height: dividerHeight,
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            textAlign: textAlign,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: margin),
              child: Divider(
                color: dividerColor,
                height: dividerHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}