import 'package:isar/isar.dart';

class User{
  Id id;
  String name;
  String email;
  bool gender;
  String avatar;
  int age;
  int role;
  int goal;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.avatar,
    required this.age,
    required this.role,
    required this.goal,
  });
}