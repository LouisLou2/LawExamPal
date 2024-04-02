import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool gender = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        leading: IconButton(
          iconSize: 70.w,
          onPressed: () {print('这里就是暂时不编写');},
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
              onPressed: () {},
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
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditItem(
                  title: AppStrings.avatar,
                  widget: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.lightBlueAccent,
                        ),
                        child: Text(
                          AppStrings.uploadImage,
                          style: AppStyles.textBtnOrLinkStyle.copyWith(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title: AppStrings.name,
                  widget: ShadInput(
                    inputDecoration: const InputDecoration(
                      border: AppStyles.textFormFieldBorder,
                    ),
                    style: AppStyles.bodySmallDark,
                    cursorColor: AppColors.purpleBlue,
                    selectionColor: AppColors.purpleBlue,
                    placeholder: Text(
                      AppStrings.pleaseEnterName,
                      style: AppStyles.bodySmall.copyWith(color:AppColors.silenceColor),
                    ),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title: AppStrings.gender,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: gender
                              ? AppColors.purpleBlue
                              : AppColors.white2,
                          fixedSize: const Size(50, 50),
                        ),
                        icon: Icon(
                          Icons.male,
                          color: gender? AppColors.white0 : AppColors.darkText0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: !gender
                              ? AppColors.purpleBlue
                              : AppColors.white2,
                          fixedSize: const Size(50, 50),
                        ),
                        icon: Icon(
                          Icons.female,
                          color: !gender? AppColors.white0 : AppColors.darkText0,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                EditItem(
                  title: AppStrings.age,
                  widget: ShadInput(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.datetime,
                    style: AppStyles.bodySmallDark,
                    cursorColor: AppColors.purpleBlue,
                    selectionColor: AppColors.purpleBlue,
                    placeholder: Text(
                      AppStrings.pleaseEnterAge,
                      style: AppStyles.bodySmall.copyWith(color:AppColors.silenceColor),
                    ),
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                const EditItem(
                  title: AppStrings.role,
                  widget: DropdownMenu<int>(
                    textStyle: AppStyles.bodySmallDark,
                    menuStyle: MenuStyle(
                      surfaceTintColor: MaterialStatePropertyAll(AppColors.scentBlue),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: 0,
                        label: 'Student',
                      ),
                      DropdownMenuEntry(
                        value: 1,
                        label: 'Student',
                      ),
                      DropdownMenuEntry(
                        value: 2,
                        label: 'Student',
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 40,
                  color: AppColors.lightBorderColor,
                  thickness: 1,
                ),
                const EditItem(
                  title: AppStrings.goal,
                  widget: DropdownMenu<int>(
                    textStyle: AppStyles.bodySmallDark,
                    menuStyle: MenuStyle(
                      surfaceTintColor: MaterialStatePropertyAll(AppColors.scentBlue),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: 0,
                        label: 'Student',
                      ),
                      DropdownMenuEntry(
                        value: 1,
                        label: 'Student',
                      ),
                      DropdownMenuEntry(
                        value: 2,
                        label: 'Student',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditItem extends StatelessWidget {
  final Widget widget;
  final String title;
  const EditItem({
    super.key,
    required this.widget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: AppStyles.bodySmallDark,
        ),
        SizedBox(width: 200.w), // 10.w = 10 * ScreenUtil().scaleWidth
        Expanded(
          flex:2,
          child: widget,
        )
      ],
    );
  }
}