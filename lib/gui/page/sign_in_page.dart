import 'package:easy_cse/constant/app_pic.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/linear_gradient_bg.dart';
import 'package:easy_cse/gui/widget/named_divider.dart';
import 'package:easy_cse/service/model_state_manager.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({Key? key}): super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //使用它，可以在表单组件的外部使用表单状态
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> pwdVisibleNotifier = ValueNotifier(true);
  bool idenValid=false;
  bool pwdValid=false;

  late final TextEditingController idenController;
  late final TextEditingController pwdController;

  void initializeControllers() {
    //listener在文本更改时会被调用
    idenController = TextEditingController()
      ..addListener(controllerListener);
    pwdController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    idenController.dispose();
    pwdController.dispose();
  }

  bool allFieldValid(){
    //return idenValid && pwdValid;
    //或者使用_formKey.currentState.validate()来验证表单
    return _formKey.currentState?.validate()??false;
  }

  String? validateEmail(String? value){
  print("validateEmail");
    if(value==null||value.isEmpty){
      idenValid=false;
      return AppStrings.pleaseEnterEmailAddress;
    }else if(FormatTool.isEmailValid(value)){
      idenValid=false;
      return AppStrings.invalidEmailAddress;
    }
    idenValid=true;
    return null;
  }
  String? validatePwd(String? value){
    print("validatePwd");
    if(value==null||value.isEmpty){
      pwdValid=false;
      return AppStrings.pleaseEnterPassword;
    }else if(FormatTool.isPwdValid(value)){
      pwdValid=false;
      return AppStrings.invalidPassword;
    }
    pwdValid=true;
    return null;
  }
  void controllerListener() {
    //validate此方法是结合表单所有validator得出的结果，返回true或false
    _formKey.currentState?.validate();
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        margin: EdgeInsets.symmetric(horizontal: 18.w,vertical: 4.h),
        child:ListView(
          padding: EdgeInsets.zero,
          children: [
            LinearGradientBg(
              borderRadius: 20.w,
              colorGroup: AppColors.freshBlueGroup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:[
                  Text(
                    AppStrings.login,
                    style: AppStyles.titleLarge.copyWith(color: AppColors.white1)
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    AppStrings.signInToYourAccount,
                    style: AppStyles.bodySmall.copyWith(color: AppColors.white1),
                  )
                ]
              )
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
                            onPressed: () => pwdVisibleNotifier.value = !pwdObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                          ),
                          border: AppStyles.textFormFieldBorder,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: const Text(
                              AppStrings.forgotPassword,
                              style: TextStyle(color: AppColors.silentBlue)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h,),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.h)),
                        surfaceTintColor: MaterialStateProperty.all(AppColors.silentBlue),
                      ),
                      onPressed: ()=>{ allFieldValid()?ModelStateManager.loginAndNav():null},
                      child: Text(
                        AppStrings.login,
                        style: AppStyles.textBtnOrLinkStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                          onPressed: (){},
                          child: Text(
                            AppStrings.register,
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
}