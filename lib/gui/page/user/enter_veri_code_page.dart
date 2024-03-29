import 'package:easy_cse/constant/app_rule.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/veri_code_prov.dart';
import 'package:easy_cse/vault/theme_bank.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_style/app_color.dart';

class EnterVeriCodePage extends StatefulWidget{
  final int count;
  final String email;
  final Function(String code) onResult;
  final Future<bool> Function() onRestart;
  const EnterVeriCodePage({Key? key,
    required this.count,
    required this.email,
    required this.onResult,
    required this.onRestart})
      :super(key:key);
  @override
  State<EnterVeriCodePage> createState()=>_EnterVeriCodePageState();
}

class _EnterVeriCodePageState extends State<EnterVeriCodePage> with WidgetsBindingObserver{

  final TextEditingController _controller = TextEditingController();
  final FocusNode _inputFocus=FocusNode();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputFocus.requestFocus();
      _controller.addListener(() {
        ProvManager.veriCodeProv.setVeriCode = _controller.text;// 此set方法会自动调用notifyListeners
      });
    });
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return const SizedBox();
  }
  Widget getCodeInput(){
    return SizedBox(
      height: 0,
      width: 0,
      child: TextField(
        controller: _controller,
      ),
    );
  }
  Widget getCodeBoxes(){
    return GridView.count(
      crossAxisCount: widget.count,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 8,
      childAspectRatio: 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
      for(int i=0;i<widget.count;++i)
        Selector<VeriCodeProv,bool>(
          selector: (_,prov)=>prov.index==i,
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
              selector: (_,prov)=>prov.getCharAt(i),
              builder: (_,codeChar,__)=>AppRule.isCharValid(codeChar)?Text(
                codeChar,
                style:AppStyles.titleMedium,
              ):const SizedBox(),
            ),
          ),
        ),
      ]
    );
  }
}