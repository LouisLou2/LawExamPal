import 'package:easy_cse/service/file_manager/path_manager.dart';
import 'package:easy_cse/util/format_tool.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tuple/tuple.dart';

import '../../constant/app_rule.dart';
import '../../constant/app_style/ui_fitter.dart';
import '../../domain/entity/persistence_kind/note.dart';
import '../../presentation/widget/helper/dialog_helper.dart';
import '../../presentation/widget/helper/snackbar_helper.dart';
import '../file_manager/image_manger.dart';
import '../navigation/navigation_helper.dart';
import '../navigation/route_collector.dart';
import '../network/note_worker.dart';
import '../network/resp_res_enum.dart';
import '../provider/note/note_prov.dart';
import '../provider/prov_manager.dart';
import '../provider/global/state_manager.dart';
import '../repository/db_handler.dart';
enum FromType{
  camera,
  gallery,
  file,
}
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
  // static Future<void> getNote(FromType way) async {
  //   // 0: 拍照 1: 从相册选择 2: 选文件
  //   String? path;
  //   if(way==FromType.file){
  //     // from file
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       path=result.files.single.path!;
  //     } else {
  //       // User canceled the picker
  //       SnackbarHelper.showToasterWithDesc(
  //       ResultCode.getDesc(ResultCode.USER_CANCELED));
  //       return;
  //     }
  //   }else{
  //     String? rawPicPath = await ImageManager.editImg(way==FromType.gallery);
  //     if (rawPicPath == null) {
  //       SnackbarHelper.showToasterWithDesc(
  //           ResultCode.getDesc(ResultCode.USER_CANCELED)
  //       );
  //       return;
  //     }
  //     String croppedPath = await ImageManager.cropImage(rawPicPath);
  //     String? compressedPath = await ImageManager.compressAndGetPathDefault(croppedPath);
  //     if (compressedPath == null) {
  //       SnackbarHelper.showToasterWithDesc(
  //       ResultCode.getDesc(ResultCode.IMAGE_ERROR));
  //       return;
  //     }
  //     path=compressedPath;
  //   }
  //   //假装得到的文件
  //   String assetsFilePath = "assets/files/def_document.pdf";
  //   DialogHelper.showLoadingDialog(
  //       userCancel: NoteWorker.cancelRequest
  //   );
  //   // what a shame,
  //   Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
  //   Future.delayed(UIFitter.dialogDelay*1.5, () async{
  //     NavigationHelper.pushNamed(RouteCollector.file_preview,arguments: assetsFilePath);
  //     // 存数据库
  //     await DBHandler.addNote(Note(
  //       title: "新笔记 ${DateTime.now().toString()}",
  //       imagePath: way==2?null:path,
  //       userId: sprov.user.id,
  //       filePath: assetsFilePath,
  //       time: DateTime.now(),
  //     ));
  //     showInitialNote();
  //   });
  // }
  static Future<void> getNote(FromType way) async {
    // 0: 拍照 1: 从相册选择 2: 选文件
    String? path;
    if(way==FromType.file){
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
      String? rawPicPath = await ImageManager.editImg(way==FromType.gallery);
      if (rawPicPath == null) {
        SnackbarHelper.showToasterWithDesc(
            ResultCode.getDesc(ResultCode.USER_CANCELED)
        );
        return;
      }
      String croppedPath = await ImageManager.cropImage(rawPicPath);
      String? compressedPath = await ImageManager.compressAndGetPathDefault(croppedPath);
      if (compressedPath == null) {
        SnackbarHelper.showToasterWithDesc(
            ResultCode.getDesc(ResultCode.IMAGE_ERROR));
        return;
      }
      path=compressedPath;
    }
    // 先开始加载
    DialogHelper.showLoadingDialog(
        userCancel: NoteWorker.cancelRequest
    );
    // 开始请求
    String token=sprov.user.token;
    Tuple2<int,String?> res=await NoteWorker.getNoteFileUrl(token, path);
    if(res.item1!=ResultCode.SUCCESS){
      // 请求失败
      Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      return;
    }
    // 请求成功,开始下载
    // 指定保存路径
    String savePath=PathManager.makeDefaultNotePath(sprov.user);
    int code=await NoteWorker.downloadNoteFile(res.item2!, savePath);
    if(code!=ResultCode.SUCCESS){
      // 下载失败
      Future.delayed(UIFitter.dialogDelay, DialogHelper.dismissDialog);
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(code));
      return;
    }
    // 下载成功
    Future.delayed(
      UIFitter.dialogDelay,
      (){
        DialogHelper.dismissDialog();
        NavigationHelper.pushNamed(RouteCollector.file_preview,arguments: savePath);
      },
    );
    // 存数据库
    final now = DateTime.now();
    await DBHandler.addNote(Note(
      title: '新笔记 ${FormatTool.secScaleStr(now)}',
      imagePath: way==FromType.file?null:path,
      userId: sprov.user.id,
      filePath: savePath,
      time: now,
    ));
    showInitialNote();
  }
}