// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_cse/constant/app_style/app_color.dart';
import 'package:easy_cse/constant/app_style/app_style.dart';
import 'package:easy_cse/gui/widget/helper/dialog_helper.dart';
import 'package:easy_cse/service/handler/auth_handler.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/app_string.dart';
import '../../../service/navigation/route_collector.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkText0,
        surfaceTintColor: Colors.transparent,
        title: const Text("个人信息"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          const Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Rachael Wagne",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Junior Product Designer")
            ],
          ),
          const SizedBox(height: 25),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "Complete your profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "(1/5)",
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 7,
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Colors.blue : Colors.black12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final card = profileCompletionCards[index];
                return SizedBox(
                  width: 160,
                  child: Card(
                    shadowColor: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          card.icon,
                          const SizedBox(height: 10),
                          Text(
                            card.title,
                            textAlign: TextAlign.center,
                            style: AppStyles.bodySmallDark,
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(card.buttonText),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
              const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: profileCompletionCards.length,
            ),
          ),
          const SizedBox(height: 35),
          ...List.generate(
            customListTiles.length,
              (index) {
              final tile = customListTiles[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: tile.icon,
                    title: Text(
                      tile.title,
                      style: AppStyles.bodySmallDark,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: tile.onTap,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void logout() {
  DialogHelper.showAskDialog(
    title: AppStrings.sureToLogout,
    text: AppStrings.eraseUserState,
    onYes: () {
      AuthHandler.logout();
    },
    willCloseDialog: true,
  );
}

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final Icon icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Set Your Profile Details",
    icon: const Icon(CupertinoIcons.person_circle),
    buttonText: "Continue",
  ),
  ProfileCompletionCard(
    title: "Upload your resume",
    icon: const Icon(CupertinoIcons.doc),
    buttonText: "Upload",
  ),
  ProfileCompletionCard(
    title: "Add your skills",
    icon: const Icon(CupertinoIcons.square_list),
    buttonText: "Add",
  ),
];

class CustomListTile {
  final Icon icon;
  final String title;
  final VoidCallback? onTap;
  CustomListTile({
    required this.icon,
    required this.title,
    this.onTap,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: const Icon(Icons.person),
    title: "个人信息",
    onTap: ()=>NavigationHelper.pushNamed(RouteCollector.edit_profile),
  ),
  CustomListTile(
    icon: const Icon(Icons.insights),
    title: "Activity",
  ),
  CustomListTile(
    icon: const Icon(Icons.location_on_outlined),
    title: "Location",
  ),
  CustomListTile(
    title: "Notifications",
    icon: const Icon(CupertinoIcons.bell),
  ),
  CustomListTile(
    title: "Logout",
    icon: const Icon(
      Icons.exit_to_app,
      color: AppColors.thickRed,
    ),
    onTap: logout,
  ),
];