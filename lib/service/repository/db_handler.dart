import 'dart:async';

import 'package:easy_cse/constant/app_rule.dart';
import 'package:easy_cse/domain/entity/persistence_kind/mark.dart';
import 'package:easy_cse/domain/entity/persistence_kind/note.dart';
import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/domain/entity/persistence_kind/user.dart';
import 'package:isar/isar.dart';

import '../file_manager/path_manager.dart';

class DBHandler {
  static late final Isar db;

  static Future<void> init() async {
    db = await Isar.open(
      [UserSchema,QuestionHistorySchema,NoteSchema,MarkSchema],
      directory: PathManager.dbDir.path,
      inspector: true,
    );
  }

  static Future<User?> getLastLoginUser() {
    // 先从markSchema中找到最后登录的用户
    assert (db.marks.countSync() <= 1);
    int? userId=db.marks.where().findFirstSync()?.lastUserId;
    if(userId==null){
      //说明这是第一次登录，或者前面的登录都无效了
      return Future(() => null);
    }
    return db.users.get(userId);
  }

  static Future<void> setLastLoginUser(int? userId) async {
    db.writeTxn(() async {
      final mark=await db.marks.where().findFirst();
      if(mark==null){
        db.marks.put(Mark(lastUserId: userId));
      }else{
        mark.lastUserId=userId;
        db.marks.put(mark);
      }
    });
  }

  static Future<void> clearLastLoginUser() async {
    db.writeTxn(() async {
      final mark=await db.marks.where().findFirst();
      if(mark!=null){
        db.marks.delete(mark.id);
      }
    });
  }

  static Future<int> addOrUpdateUser(User user) async {
    return db.writeTxn(()async{
      return db.users.put(user);
    });
  }

  static Future<List<QuestionHistory>> getQuesHistory(int userId,int page)async {
    // 从page开始获取, 时间顺序,页数从0开始
    return db.questionHistorys.where().filter().userIdEqualTo(userId).sortByTimeDesc().offset(page*AppRule.historyPageSize).limit(AppRule.historyPageSize).findAll();
  }
  static Future<List<Note>> getNoteList(int userId,int page)async {
    // 从page开始获取, 时间顺序,页数从0开始
    return db.notes.where().filter().userIdEqualTo(userId).sortByTimeDesc().offset(page*AppRule.historyPageSize).limit(AppRule.historyPageSize).findAll();
  }

  static Future<void> addQuesHistory(QuestionHistory history) async {
    db.writeTxn(() async {
      db.questionHistorys.put(history);
    });
  }
  static Future<void> addNote(Note note) async {
    await db.writeTxn(() async {
      db.notes.put(note);
    });
  }
}