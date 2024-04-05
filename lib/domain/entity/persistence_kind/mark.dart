import 'package:isar/isar.dart';
part 'mark.g.dart';

@collection
class Mark{
  Id id=Isar.autoIncrement;
  int? lastUserId;
  Mark({this.lastUserId});
}