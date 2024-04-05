import 'package:isar/isar.dart';
part 'ques_history.g.dart';

@collection
class QuestionHistory{

  Id id=Isar.autoIncrement;// 不会云端同步(暂时)

  int userId;

  @Index(unique: true,)
  String imgPath;

  @Index(unique: true,)
  DateTime time;

  QuestionHistory({
    required this.userId,
    required this.imgPath,
    required this.time,
  });
}