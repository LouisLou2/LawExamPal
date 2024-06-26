import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:easy_cse/constant/app_properties.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {

  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> features = [
      // Feature's type must be `WhatsNewFeature`
      WhatsNewFeature(
        icon: Icon(
          CupertinoIcons.book,
          color: CupertinoColors.systemRed.resolveFrom(context),
        ),
        title: Text(AppProperties.features[0].title),
        description: Text(
          AppProperties.features[0].desc,
        ),
      ),
      WhatsNewFeature(
        icon: Icon(
          Icons.school_outlined,
          color: CupertinoColors.systemRed.resolveFrom(context),
        ),
        title: Text(AppProperties.features[1].title),
        description: Text(
          AppProperties.features[1].desc,
        ),
      ),
      WhatsNewFeature(
        icon: Icon(
          CupertinoIcons.wand_stars,
          color: CupertinoColors.systemRed.resolveFrom(context),
        ),
        title: Text(AppProperties.features[1].title),
        description: Text(
          AppProperties.features[1].desc,
        ),
      ),
    ];
    TextStyle btnStyle = AppStyles.iconTextStyle.copyWith(
      color: AppColors.white1,
      fontWeight: FontWeight.normal,
      letterSpacing: 6,
    );
    return CupertinoOnboarding(
      bottomButtonColor: AppColors.discoBallBlue,
      bottomButtonBorderRadius: BorderRadius.circular(8),

      onPressed: ()=>NavigationHelper.pushReplacementNamed(RouteCollector.sign_up),
      onPressedOnLastPage: ()=>NavigationHelper.pushReplacementNamed(RouteCollector.sign_in),

      bottomButtonChild: Text(
        AppStrings.signin,
        style:btnStyle,
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
          onPressed: ()=>NavigationHelper.pushReplacementNamed(RouteCollector.sign_up),
          child: DefaultTextStyle(
            style: btnStyle,
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
                AppStrings.welcome1,
                style: AppStyles.titleLarge,
              ),
              Text(
                AppStrings.welcome2,
                style: AppStyles.titleLarge,
              ),
            ],
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 25),
            itemCount: features.length,
            itemBuilder: (context, index) {
              return features[index];
            },
          ),
        ),
      ],
    );
  }
}