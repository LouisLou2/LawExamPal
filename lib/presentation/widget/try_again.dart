import 'package:flutter/material.dart';

import '../../constant/app_string.dart';
import '../../constant/app_style/app_color.dart';
import '../../constant/app_style/app_style.dart';

class TryAgainWidget extends StatelessWidget {
  final VoidCallback? onTryAgain;

  TryAgainWidget({super.key, this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            AppStrings.notFound,
            style: AppStyles.iconTextStyle,
          ),
          OutlinedButton(
            onPressed: onTryAgain,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.thickRed, width: 2),
            ),
            child: const Text(
              AppStrings.tryAgain,
              style: AppStyles.bodySmallDark,
            ),
          ),
        ],
      ),
    );
  }
}