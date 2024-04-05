import 'dart:io';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:easy_cse/service/handler/user_info_handler.dart';
import 'package:easy_cse/service/knowledge/basic_knowledge.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/provider/state_manager.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../constant/app_style/app_pic.dart';
import '../../../service/navigation/route_collector.dart';
import '../../../service/provider/prov_manager.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  bool gender = false;
  late StateManagerProv sprov;

  @override
  void initState() {
    sprov = ProvManager.stateProv;
    sprov.copyUserToTmp();
    super.initState();
  }

  void finishAddingInfo() {
    sprov.firstAddInfo = false;
    NavigationHelper.pushReplacementNamed(RouteCollector.main);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sprov.user.birthday??DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now(),
    );
    if (picked != null) {
      sprov.tmpBirthday = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        leading: sprov.firstAddInfo?
            TextButton(
              onPressed: finishAddingInfo,
              child: const Text(
                AppStrings.skip,
                style: AppStyles.bodySmallDark,
              ),
            )
            :IconButton(
              iconSize: 20.h,
              onPressed: NavigationHelper.pop,
              icon: const Icon(Icons.close_rounded),
            ),
        title: const Text(
          AppStrings.detailInfo,
          style: AppStyles.titleMedium,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: IconButton(
              onPressed: ()=>UserInfoHandler.updateUserInfo(isfirst: sprov.firstAddInfo),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.purpleBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(140.w, 50.h),
                elevation: 3,
              ),
              icon: const Icon(Icons.check, color:AppColors.white0),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.all(UIParams.defPadding),
            decoration: BoxDecoration(
              color: AppColors.white0,
              borderRadius: BorderRadius.circular(UIParams.smallBorderR),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditItem(
                  title: AppStrings.avatar,
                  widget: Column(
                    children: [
                      Selector<StateManagerProv,String?>(
                        selector: (_, prov) => prov.tmpUser.avatar,
                        builder: (_, avatar, __) => CircleAvatar(
                          radius: 50,
                          backgroundImage: (avatar != null) ? FileImage(File(avatar)) as ImageProvider : const AssetImage(AppPic.defaultAvatar),
                        ),
                      ),
                      TextButton(
                        onPressed: UserInfoHandler.prepareAvatar,
                        child: Text(
                          AppStrings.uploadImage,
                          style: AppStyles.bodySmall.copyWith(color:AppColors.purpleBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title:AppStrings.name,
                  widget: SizedBox(
                    width: 300.w,
                    child: TextField(
                      onChanged: (String value) => sprov.tmpName = value,
                      decoration: InputDecoration(
                        border: AppStyles.textFormFieldBorder,
                        focusedBorder: AppStyles.textFormFieldBorder,
                        enabledBorder: AppStyles.textFormFieldBorder,
                        errorBorder: AppStyles.textFormFieldBorder,
                        focusedErrorBorder: AppStyles.textFormFieldBorder,
                        hintText: AppStrings.pleaseEnterName,
                        hintStyle: AppStyles.bodySmall.copyWith(color:AppColors.silenceColor),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title:AppStrings.gender,
                  widget:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Selector<StateManagerProv,bool?>(
                        selector: (_, prov)=>prov.tmpUser.gender,
                        builder:(__,gender,___)=>IconButton(
                            onPressed: ()=>sprov.tmpGender = true,
                            style: IconButton.styleFrom(
                            backgroundColor: gender==true? AppColors.purpleBlue : AppColors.white2,
                            fixedSize: const Size(50, 50),
                          ),
                          icon: Icon(
                            Icons.male,
                            color: gender==true? AppColors.white0 : AppColors.darkText0,
                          ),
                        ),
                      ),
                      SizedBox(width: 50.w),
                      Selector<StateManagerProv,bool?>(
                        selector: (_, prov)=>prov.tmpUser.gender,
                        builder:(__,gender,___)=>IconButton(
                          onPressed: ()=>sprov.tmpGender = false,
                          style: IconButton.styleFrom(
                            backgroundColor: gender==false? AppColors.purpleBlue : AppColors.white2,
                            fixedSize: const Size(50, 50),
                          ),
                          icon: Icon(
                            Icons.female,
                            color: gender==false? AppColors.white0 : AppColors.darkText0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title:AppStrings.age,
                  widget: SizedBox(
                    width: 300.w,
                    child: TextButton(
                      onPressed: () => _selectDate(context),
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: AppColors.lightBorderColor),
                      ),
                      child: Selector<StateManagerProv,DateTime?>(
                        selector: (_, prov)=>prov.tmpUser.birthday,
                        builder: (_, birthday, __) => Text(
                          birthday!=null?FormatTool.dateScaleString(birthday):AppStrings.pleaseChoose,
                          style: AppStyles.bodySmallDark,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title:AppStrings.role,
                  widget: SizedBox(
                    width: 350.w,
                    child: Selector<StateManagerProv,int?>(
                      selector: (_, prov)=>prov.tmpUser.role,
                      builder: (_, role, __) => DropdownButton<String>(
                        value: sprov.tmpUser.role!=null?BasicKnowledge.getRole(sprov.tmpUser.role!):BasicKnowledge.roleList.last,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 50.sp,
                        elevation: 8,
                        style: AppStyles.bodySmallDark,
                        underline: Container(
                          height: 3,
                          color: AppColors.purpleBlue,
                        ),
                        onChanged: (String? newValue) {
                          sprov.tmpRole = BasicKnowledge.getRoleIndex(newValue!);
                        },
                        items: BasicKnowledge.roleList.map<DropdownMenuItem<String>>(
                          (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                ListTile(
                  title: const Text(
                    AppStrings.goal,
                    style: AppStyles.bodySmallDark,
                  ),
                  subtitle: Text(
                    AppStrings.pleaseChoose,
                    style: AppStyles.tinyText.copyWith(color: AppColors.silenceColor),
                  ),
                  trailing: IconButton(
                    onPressed: () {},// TODO: add goal
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final String title;
  final Widget widget;
  const EditItem({
    super.key,
    required this.widget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyles.bodySmallDark,
          ),
          widget,
        ],
      ),
    );
  }
}