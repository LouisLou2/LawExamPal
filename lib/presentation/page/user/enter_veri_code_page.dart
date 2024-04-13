import 'package:easy_cse/constant/app_rule.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/presentation/widget/info_display/headline2.dart';
import 'package:easy_cse/service/handler/auth_handler.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/user/veri_code_prov.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';

class EnterVeriCodePage extends StatefulWidget{

  const EnterVeriCodePage({super.key,});
  @override
  State<EnterVeriCodePage> createState()=>_EnterVeriCodePageState();
}

class _EnterVeriCodePageState extends State<EnterVeriCodePage> with WidgetsBindingObserver{
  final TextEditingController _controller = TextEditingController();
  final FocusNode _inputFocus=FocusNode();
  final vprov = ProvManager.veriCodeProv;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputFocus.requestFocus();
      ProvManager.veriCodeProv.startTimer();
      ProvManager.veriCodeProv.allowNext(false);
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    final vprov = ProvManager.veriCodeProv;
    if(state==AppLifecycleState.resumed){
      if(vprov.lastPauseTime!=null){
        vprov.pauseInterval += (DateTime.now().millisecondsSinceEpoch-vprov.lastPauseTime!)~/1000;
        vprov.lastPauseTime=null;
      }
    }
    else if(state==AppLifecycleState.paused){
      vprov.lastPauseTime=DateTime.now().millisecondsSinceEpoch;
    }
  }
  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _inputFocus.dispose();
    ProvManager.veriCodeProv.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final vprov = ProvManager.veriCodeProv;
    return Scaffold(
      backgroundColor: AppColors.white0,
      appBar: AppBar(
        backgroundColor: AppColors.white0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            HeadLine2(
              title: AppStrings.enterVeriCode,
              size: 70.sp,
              subTitle: '${AppStrings.veriCodeSentTo} ${ProvManager.stateProv.user.email}',
            ),
            SizedBox(height: 10.h),
            _getCodeInput(),
            GestureDetector(
              onTap: (){
                SystemChannels.textInput.invokeMethod('TextInput.show');
                _inputFocus.requestFocus();
              },
              child: _getCodeBoxes(),
            ),
            SizedBox(height: 4.h),
            Selector<VeriCodeProv,bool>(
              selector: (_,prov)=>prov.allowNextSend,
              builder: (_,restart,__)=>restart?TextButton(
                onPressed: sendAgain,
                child: Text(
                  AppStrings.sendAgain,
                  style: AppStyles.textBtnOrLinkStyle.copyWith(fontSize: 40.sp),
                ),
              ):Selector<VeriCodeProv,int>(
                selector: (_,prov)=>prov.left,
                builder: (_,left,__)=>Text(
                  '$left ${AppStrings.secondsToResend}',
                  style: AppStyles.bodySmallDark,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCodeInput(){
    return SizedBox(
      height: 0,
      width: 0,
      child: TextField(
        controller: _controller,
        focusNode: _inputFocus,
        maxLength: AppRule.veriCodeLength,
        keyboardType: TextInputType.number,
        enableInteractiveSelection: false,// 禁止长按弹出菜单
        inputFormatters: [
          FilteringTextInputFormatter.allow(FormatTool.onlyNumberRegex),
        ],
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: tyingCode,
      ),
    );
  }
  Widget _getCodeBoxes(){
    return GridView.count(
      crossAxisCount: AppRule.veriCodeLength,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 20.w,
      childAspectRatio: 0.95,
      children: List.generate(
          AppRule.veriCodeLength,
        (index) => Selector<VeriCodeProv,bool>(
          key: ValueKey(index),
          selector: (_,prov)=>prov.index==index,
          builder: (_,now,__)=>Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.scentBlue.withOpacity(0.5),
                border: now?Border.all(
                  color: AppColors.purpleBlue,
                  width: 2,
                ):null,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Selector<VeriCodeProv,String>(
              selector: (_,prov)=>prov.getCharAt(index),
              builder: (_,codeChar,__)=>AppRule.isCharValid(codeChar)?Text(
                codeChar,
                style:AppStyles.titleMedium,
              ):const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
  void tyingCode(String code){
    vprov.setVeriCode = code;
    if(code.length==AppRule.veriCodeLength){
      sendVeriCode(code);
    }
  }
  void sendVeriCode(String code){
    AuthHandler.executeSendVeriCode(code);
  }
  void sendAgain(){
    print('@@@@@@@@@@@sendAgain');
    vprov.allowNext(false);
    AuthHandler.executeRequestVeriCode();
  }
}