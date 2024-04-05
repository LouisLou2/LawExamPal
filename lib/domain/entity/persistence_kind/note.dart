import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note {

  final Id id = Isar.autoIncrement;//本地id, 笔记不会云端同步(目前)

  String title;

  int userId;

  String? imagePath;

  @Index(unique: true,)
  String filePath;

  @Index(unique: true,)
  DateTime time;

  Note({
    required this.userId,
    required this.title,
    required this.filePath,
    required this.time,
    this.imagePath,
  });
}