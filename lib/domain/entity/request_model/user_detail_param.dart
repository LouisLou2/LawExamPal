import 'package:dio/dio.dart';
import 'package:easy_cse/util/format_tool.dart';

import '../persistence_kind/user.dart';

class UserDetail{
  final String token;
  final String? name;
  final bool? gender;
  final DateTime? birthday;
  String? avatarPath;
  final int? role;
  final int? goal;
  UserDetail(
    this.token, {
    this.name,
    this.gender,
    this.birthday,
    this.role,
    this.goal,
    this.avatarPath,
  });
  factory UserDetail.fromUser(User user){
    return UserDetail(
      user.token,
      name: user.name,
      gender: user.gender,
      birthday: user.birthday,
      role: user.role,
      goal: user.goal,
      avatarPath: user.avatar,
    );
  }
  Future<Map<String, dynamic>> toJson() async{
    MultipartFile? avatar;
    if(avatarPath!=null) {
      avatar = await MultipartFile.fromFile(avatarPath!);
    }
    return {
      'token': token,
      if(name!=null)
      'name': name,
      if(gender!=null)
      'gender':gender,
      if(birthday!=null)
      'birthday':FormatTool.utcDateScaleString(birthday!),
      if(avatar!=null)
      'avatar':avatar,
      if(role!=null)
      'role':role,
      if(goal!=null)
      'goal':goal,
      if(avatar!=null)
      'avatar':avatar,
    };
  }
}