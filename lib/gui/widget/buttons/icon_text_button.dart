import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
    required this.color, required this.size,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints.expand(width: size, height: size),
        child: InkWell(
          borderRadius: BorderRadius.circular(size*0.5),
          onTap: onTap,
          child: Column(
            children: [
              Icon(icon,
                color: color,
                size: size*0.5,
              ),
              SizedBox(height: size*0.06),
              Text(text,
                maxLines: 2,
                style: AppStyles.iconTextStyle.copyWith(
                  color: color,
                  fontSize: size*0.2,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}