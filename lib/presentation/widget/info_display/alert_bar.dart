import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/material.dart';

class AlertBar extends StatelessWidget {
  final String message;
  final Color? color;
  final double? radius;
  final VoidCallback? onTap;

  const AlertBar({super.key, required this.message, this.color, this.radius, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:color??AppColors.scentBlue,
        borderRadius: BorderRadius.all(Radius.circular(radius??10)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            const Icon(Icons.notifications_active_outlined, color: AppColors.white0),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppStyles.tinyText.copyWith(color: AppColors.white0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}