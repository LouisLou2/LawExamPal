import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    List<Widget> features = [
      // Feature's type must be `WhatsNewFeature`
      WhatsNewFeature(
        icon: Icon(
          CupertinoIcons.mail,
          color: CupertinoColors.systemRed.resolveFrom(context),
        ),
        title: const Text('Found Events'),
        description: const Text(
          'Siri suggests events found in Mail, Messages, and Safari, so you can add them easily, such as flight reservations and hotel bookings.',
        ),
      ),
      WhatsNewFeature(
        icon: Icon(
          CupertinoIcons.time,
          color: CupertinoColors.systemRed.resolveFrom(context),
        ),
        title: const Text('Time to Leave'),
        description: const Text(
          "Calendar uses Apple Maps to look up locations, traffic conditions, and transit options to tell you when it's time to leave.",
        ),
      ),
    ];
    return CupertinoOnboarding(
      bottomButtonColor: AppColors.discoBallBlue,
      bottomButtonBorderRadius: BorderRadius.circular(8),
      onPressed: (){print('onPressed');},
      bottomButtonChild: const Text(
        AppStrings.login,
      ),
      widgetAboveBottomButton: Padding(
        padding: const EdgeInsets.only(
          left: 22,
          right: 22,
          bottom: 20,
        ),
        child: CupertinoButton(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.iconPink,
          padding: const EdgeInsets.all(16),
          onPressed: (){},
          child: DefaultTextStyle(
            style: AppStyles.iconTextStyle.copyWith(
              color: AppColors.white1,
              letterSpacing: 6,
            ),
            child: const Row(
              children: [
                Spacer(),
                Text(AppStrings.signup,),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      pages: [
        CupertinoOnboardingPage(
          title: const Column(
            children: [
              Text(
                '登录以开启',
                style: AppStyles.titleLarge,
              ),
              Text(
                '学习之旅',
                style: AppStyles.titleLarge,
              ),
            ],
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 25),
            itemCount: 2,
            itemBuilder: (context, index) {
              return features[index];
            },
          ),
        ),
      ],
    );
  }
}