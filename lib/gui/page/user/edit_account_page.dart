import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/constant/app_style/ui_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool gender = false;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      appBar: AppBar(
        backgroundColor: AppColors.white1,
        leading: IconButton(
          iconSize: 20.h,
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
            child: Column(
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
                      SizedBox(width: 50.w), // 10.w = 10 * ScreenUtil().scaleWidth
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
                  title:AppStrings.role,
                  widget: SizedBox(
                    width: 300.w,
                    child: TextButton(
                      onPressed: () => _selectDate(context),
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: AppColors.lightBorderColor),
                      ),
                      child: Text(
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                        style: AppStyles.bodySmallDark,
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
                    width: 150.w,
                    child: DropdownButton<String>(
                      value: '学生',
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 50.sp,
                      elevation: 8,
                      style: AppStyles.bodySmallDark,
                      underline: Container(
                        height: 3,
                        color: AppColors.purpleBlue,
                      ),
                      onChanged: (String? newValue) {},
                      items: <String>['学生', '教师', '其他']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                    '山东省公务员考试',
                    style: AppStyles.tinyText.copyWith(color: AppColors.silenceColor),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
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