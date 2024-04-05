import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class User{
  // 均为公有
  Id id=Isar.autoIncrement;// 只是本地的id，与服务器无关

  String token;

  @Index(unique: true,)
  String email;

  String? name;
  bool? gender;
  String? avatar;
  DateTime lastLoginTime;
  DateTime? birthday;
  int? role;
  int? goal;


  User({
    required this.token,
    required this.email,
    required this.lastLoginTime,
    this.birthday,
    this.name,
    this.gender,
    this.avatar,
    this.role,
    this.goal,
  });

   User.empty():this(
     token: '',
     email: '',
     lastLoginTime: DateTime.now(),
   );

   User.require({
     required this.token,
     required this.email,
     required this.lastLoginTime,
   });

   void addMoreInfo({
     required String name,
     required bool gender,
     required String avatar,
     required int role,
     required int goal,
     required DateTime birthday,
   }){
      this.name=name;
      this.gender=gender;
      this.avatar=avatar;
      this.role=role;
      this.goal=goal;
   }
   User copyWith({
    int?id,
    String? token,
    String? email,
    String? name,
    bool? gender,
    String? avatar,
    DateTime? lastLoginTime,
    DateTime? birthday,
    int? role,
    int? goal,
   }){
      return User(
        token: token??this.token,
        email: email??this.email,
        name: name??this.name,
        gender: gender??this.gender,
        avatar: avatar??this.avatar,
        lastLoginTime: lastLoginTime??this.lastLoginTime,
        birthday: birthday??this.birthday,
        role: role??this.role,
        goal: goal??this.goal,
      );
   }
    @override
    String toString() {
      return 'User{id: $id, token: $token, email: $email, name: $name, gender: $gender, avatar: $avatar, lastLoginTime: $lastLoginTime, birthday: $birthday, role: $role, goal: $goal}';
   }
}