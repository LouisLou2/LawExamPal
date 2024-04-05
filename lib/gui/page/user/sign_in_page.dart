import 'package:easy_cse/constant/app_rule.dart';
import 'package:easy_cse/constant/app_style/app_pic.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/decorations/linear_gradient_bg.dart';
import 'package:easy_cse/gui/widget/helper/snackbar_helper.dart';
import 'package:easy_cse/gui/widget/layout_helper_widget/named_divider.dart';
import 'package:easy_cse/service/handler/auth_handler.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/situation_enum.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //使用它，可以在表单组件的外部使用表单状态
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> pwdVisibleNotifier = ValueNotifier(true);
  late final TextEditingController idenController;
  late final TextEditingController pwdController;

  late int lastTime;

  String? emailTip;
  String? pwdTip;

  @override
  void initState() {
    lastTime=0;
    emailTip=pwdTip=null;
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void initializeControllers() {
    //listener在文本更改时会被调用
    idenController = TextEditingController()
      ..addListener(validateAllThrottle);
    pwdController = TextEditingController()
      ..addListener(validateAllThrottle);
  }

  void disposeControllers() {
    idenController.dispose();
    pwdController.dispose();
  }

  void validateAllThrottle(){
    int now = DateTime.now().millisecondsSinceEpoch;
    if(now-lastTime<AppRule.threshold)return;
    lastTime=now;
    _formKey.currentState?.validate();
  }

  // 此方法最后调用
  bool allFieldValid(){
    return _formKey.currentState?.validate()??false;
  }


  String? validatePwd(String? value){
    if(value==null||value.isEmpty){
      emailTip= AppStrings.pleaseEnterPassword;
    }else if(!FormatTool.isPwdValid(value)){
      emailTip=AppStrings.invalidPassword;
    }else{
      emailTip=null;
    }
    return emailTip;
  }

  String? validateEmail(String? value){
    if(value==null||value.isEmpty){
      pwdTip= AppStrings.pleaseEnterEmailAddress;
    }else if(!FormatTool.isEmailValid(value)){
      pwdTip= AppStrings.invalidEmailAddress;
    }else{
      pwdTip=null;
    }
    return pwdTip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 4.h),
        child:ListView(
          padding: EdgeInsets.only(top: 20.h),
          children: [
            LinearGradientBg(
              borderRadius: 20.w,
              colorGroup: AppColors.freshBlueGroup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  Text(
                    AppStrings.signin,
                    style: AppStyles.titleLarge.copyWith(color: AppColors.white1)
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    AppStrings.signInToYourAccount,
                    style: AppStyles.bodySmall.copyWith(color: AppColors.white1),
                  ),
                ],
              ),
            ),
            Form(
              key:_formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: AppStrings.email,
                        hintText: AppStrings.email,
                        prefixIcon: Icon(Icons.email),
                        border: AppStyles.textFormFieldBorder
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: idenController,
                      validator: validateEmail,
                    ),
                    SizedBox(height: 20.h),
                    ValueListenableBuilder(
                      valueListenable: pwdVisibleNotifier,
                      builder: (_, pwdObscure, __)=>TextFormField(
                        obscureText: pwdObscure,
                        controller: pwdController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        //onChanged: (_) => _formKey.currentState?.validate(),
                        decoration: InputDecoration(
                          labelText: AppStrings.password,
                          hintText: AppStrings.password,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              pwdObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => pwdVisibleNotifier.value = !pwdObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                          ),
                          border: AppStyles.textFormFieldBorder,
                        ),
                        validator: validatePwd,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            AppStrings.forgotPassword,
                            style: AppStyles.bodySmall.copyWith(color: AppColors.silentBlue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8.h)),
                        surfaceTintColor: MaterialStateProperty.all(AppColors.silentBlue),
                      ),
                      onPressed: signInPressed,
                      child: const Text(
                        AppStrings.signin,
                        style: AppStyles.textBtnOrLinkStyle,
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    NamedDivider(
                      height: 20.h,
                      name: AppStrings.orLoginWith,
                      dividerHeight: 1,
                      dividerColor: AppColors.silenceColor,
                      textColor: AppColors.silenceColor,
                    ),
                    SizedBox(height: 8.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: (){},
                            icon: SvgPicture.asset(AppPic.google, width: 14),
                            label: const Text(
                                AppStrings.facebook,
                                style: TextStyle(color: Colors.black)
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: (){},
                            icon: SvgPicture.asset(AppPic.facebook, width: 14),
                            label: const Text(
                              AppStrings.facebook,
                              style: TextStyle(color: AppColors.darkText0),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.doNotHaveAnAccount,
                          style: AppStyles.bodySmall.copyWith(color: AppColors.darkText0),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: ()=>NavigationHelper.pushReplacementNamed(RouteCollector.sign_up),
                          child: Text(
                            AppStrings.signup,
                            style: AppStyles.bodySmall.copyWith(color: AppColors.silentBlue),
                          ),
                        ),
                      ],
                    )
                  ]
                )
              )
            )
          ],
        ),
      )
    );
  }

  // logic
  String makeTip(){
    return '${emailTip!=null?'$emailTip; ':''}${pwdTip!=null?'$pwdTip; ':''}${pwdTip!=null?AppStrings.passwordRule:''}';
  }
  void signInPressed() async {
    if(allFieldValid()) {
      AuthHandler.executeSignIn(
        email: idenController.text,
        password: pwdController.text,
      );
    }
    else{
      SnackbarHelper.showToaster(
        title: AppStrings.badInput,
        message: makeTip(),
        kind: SituationEnum.ERROR,
      );
    }
  }
}