import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/decorations/linear_gradient_bg.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_rule.dart';
import '../../../constant/situation_enum.dart';
import '../../../service/handler/auth_handler.dart';
import '../../../service/navigation/navigation_helper.dart';
import '../../../service/navigation/route_collector.dart';
import '../../widget/helper/snackbar_helper.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //使用它，可以在表单组件的外部使用表单状态
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> pwdVisibleNotifier1 = ValueNotifier(true);
  final ValueNotifier<bool> pwdVisibleNotifier2 = ValueNotifier(true);

  late final TextEditingController idenController;
  late final TextEditingController pwdController1;
  late final TextEditingController pwdController2;

  late int lastTime;
  String? emailTip;
  String? pwdTip;
  String? pwdTip2;

  @override
  void initState() {
    lastTime=0;
    emailTip=pwdTip=pwdTip2=null;
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
      ..addListener(validateThrottle);
    pwdController1 = TextEditingController()
      ..addListener(validateThrottle);
    pwdController2 = TextEditingController()
      ..addListener(validateThrottle);
  }

  void validateThrottle(){
    int now = DateTime.now().millisecondsSinceEpoch;
    if(now-lastTime<AppRule.threshold)return;
    lastTime=now;
    _formKey.currentState?.validate()??false;
  }
  void disposeControllers() {
    idenController.dispose();
    pwdController1.dispose();
    pwdController2.dispose();
  }

  // 此方法最后调用
  bool allFieldValid(){
    return _formKey.currentState?.validate()??false;
  }

  String? validateEmail(String? value){
    if(value==null||value.isEmpty){
      emailTip=AppStrings.pleaseEnterEmailAddress;
    }else if(!FormatTool.isEmailValid(value)){
     emailTip=AppStrings.invalidEmailAddress;
    }else{
      emailTip=null;
    }
    return emailTip;
  }

  String? validatePwd(String? value){
    if(value==null||value.isEmpty){
      pwdTip= AppStrings.pleaseEnterPassword;
    }else if(!FormatTool.isPwdValid(value)){
      pwdTip=AppStrings.invalidPassword;
    }else{
      pwdTip=null;
    }
    return pwdTip;
  }

  String? validatePwd2(String? value){
    if(value==null||value.isEmpty){
      pwdTip2=AppStrings.pleaseEnterPassword;
    }else if(value!=pwdController1.text){
      pwdTip2= AppStrings.notSamePassword;
    }else{
      pwdTip2=null;
    }
    return pwdTip2;
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
                      AppStrings.signup,
                      style: AppStyles.titleLarge.copyWith(color: AppColors.white1)
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    AppStrings.signUpAccount,
                    style: AppStyles.bodySmall.copyWith(color: AppColors.white1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
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
                        border: AppStyles.textFormFieldBorder,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: idenController,
                      validator: validateEmail,
                    ),
                    SizedBox(height: 15.h),
                    ValueListenableBuilder(
                      valueListenable: pwdVisibleNotifier1,
                      builder: (_, pwdObscure, __)=>TextFormField(
                        obscureText: pwdObscure,
                        controller: pwdController1,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePwd,
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
                            onPressed: () => pwdVisibleNotifier1.value = !pwdObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                          ),
                          border: AppStyles.textFormFieldBorder,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    ValueListenableBuilder(
                      valueListenable: pwdVisibleNotifier2,
                      builder: (_, pwdObscure, __)=>TextFormField(
                        obscureText: pwdObscure,
                        controller: pwdController2,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        validator: validatePwd2,
                        //onChanged: (_) => _formKey.currentState?.validate(),
                        decoration: InputDecoration(
                          labelText: AppStrings.confirmPassword,
                          hintText: AppStrings.confirmPassword,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              pwdObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () => pwdVisibleNotifier2.value = !pwdObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                          ),
                          border: AppStyles.textFormFieldBorder,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8.h)),
                        surfaceTintColor: MaterialStateProperty.all(AppColors.silentBlue),
                      ),
                      onPressed: signUpPressed,
                      child: const Text(
                        AppStrings.signup,
                        style: AppStyles.textBtnOrLinkStyle,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.iHaveAnAccount,
                          style: AppStyles.bodySmall.copyWith(color: AppColors.darkText0),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: ()=>NavigationHelper.pushReplacementNamed(RouteCollector.sign_in),
                          child: Text(
                            AppStrings.signin,
                            style: AppStyles.bodySmall.copyWith(color: AppColors.silentBlue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // logic
  String makeTip(){
    return '${emailTip!=null?'$emailTip; ':''}${pwdTip!=null?'$pwdTip; ':''}${pwdTip2!=null?'$pwdTip2; ':''}${pwdTip!=null?AppStrings.passwordRule:''}';
  }
  void signUpPressed() async {
    if(allFieldValid()) {
      AuthHandler.executeSignUp(
        email: idenController.text,
        password: pwdController1.text,
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