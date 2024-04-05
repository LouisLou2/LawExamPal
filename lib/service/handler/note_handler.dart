import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../constant/app_rule.dart';
import '../../constant/app_style/ui_fitter.dart';
import '../../domain/entity/persistence_kind/note.dart';
import '../../gui/widget/helper/dialog_helper.dart';
import '../../gui/widget/helper/snackbar_helper.dart';
import '../file_manager/image_manger.dart';
import '../navigation/navigation_helper.dart';
import '../navigation/route_collector.dart';
import '../network/note_worker.dart';
import '../network/resp_res_enum.dart';
import '../provider/note_prov.dart';
import '../provider/prov_manager.dart';
import '../provider/state_manager.dart';
import '../repository/db_handler.dart';

class NoteHandler{
  static final StateManagerProv sprov=ProvManager.stateProv;
  static final NoteProv nprov=ProvManager.noteProv;

  static Future<void> showInitialNote() async {
    nprov.setNoteLoading();
    List<Note> list=await DBHandler.getNoteList(sprov.user.id, nprov.nowPage);
    if(list.length<AppRule.historyPageSize){
      nprov.over=true;
    }else{
      ++nprov.nowPage;
    }
    nprov.setNoteDone(list);
  }
  static Future<void> showMoreNote() async {
    if(nprov.over)return;
    nprov.setNoteLoading();
    List<Note> list=await DBHandler.getNoteList(sprov.user.id,nprov.nowPage);
    if(list.length<AppRule.historyPageSize){
      nprov.over=true;
    }else{
      ++nprov.nowPage;
    }
    nprov.addNoteDone(list);
  }
  static Future<void> showNotePreview(int index) async {
    // 取出对应filePath
    String filePath=nprov.noteList[index].filePath;
    DialogHelper.showLoadingDialog(
        userCancel: NoteWorker.cancelRequest
    );
    // 现在可以先跳到结果页
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    NavigationHelper.pushNamed(RouteCollector.file_preview,arguments: filePath);
  }
  static Future<void> getNote(int way) async {
    // 0: 拍照 1: 从相册选择 2: 选文件
    String? path;
    if(way==2){
      // from file
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        path=result.files.single.path!;
      } else {
        // User canceled the picker
        SnackbarHelper.showToasterWithDesc(
        ResultCode.getDesc(ResultCode.USER_CANCELED));
        return;
      }
    }else{
      String? rawPicPath = await ImageManager.editImg(way==1);
      if (rawPicPath == null) {
        SnackbarHelper.showToasterWithDesc(
            ResultCode.getDesc(ResultCode.IMAGE_ERROR));
        return;
      }
      String croppedPath = await ImageManager.cropImage(rawPicPath);
      String? compressedPath = await ImageManager.compressAndGetPathDefault(
          croppedPath);
      if (compressedPath == null) {
        SnackbarHelper.showToasterWithDesc(
            ResultCode.getDesc(ResultCode.IMAGE_ERROR));
        return;
      }
      path=compressedPath;
    }
    //假装得到的文件
    String assetsFilePath = "assets/files/def_document.pdf";

    DialogHelper.showLoadingDialog(
        userCancel: NoteWorker.cancelRequest
    );
    // what a shame,
    Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
    Future.delayed(UIFitter.dialogDelay*1.5, () async{
      NavigationHelper.pushNamed(RouteCollector.file_preview,arguments: assetsFilePath);
      // 存数据库
      await DBHandler.addNote(Note(
        title: "新笔记 ${DateTime.now().toString()}",
        imagePath: way==2?null:path,
        userId: sprov.user.id,
        filePath: assetsFilePath,
        time: DateTime.now(),
      ));
      showInitialNote();
    });
  }
}