import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/domain/entity/ques_search_res.dart';
import 'package:easy_cse/gui/page/ques/ques_history_page.dart';
import 'package:easy_cse/gui/widget/helper/snackbar_helper.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/network/resp_res_enum.dart';
import 'package:easy_cse/service/provider/prov_manager.dart';
import 'package:easy_cse/service/provider/state_manager.dart';
import 'package:easy_cse/service/repository/db_handler.dart';
import 'package:tuple/tuple.dart';

import '../file_manager/image_manger.dart';
import '../file_manager/path_manager.dart';
import '../navigation/route_collector.dart';
import '../network/content_worker.dart';
import '../provider/content_provider.dart';

class ContentHandler{
  static final ContentProv cprov=ProvManager.contentProv;
  static final StateManagerProv sprov=ProvManager.stateProv;

  /*搜索题目*/
  static Future<void> executeSearchQues(CaptureRequest req) async{
      String croppedPath=await ImageManager.cropImage(PathManager.lastRawPicPath);
      String? compressedPath=await ImageManager.compressAndGetPathDefault(croppedPath);
      if(compressedPath==null){
        SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(ResultCode.IMAGE_ERROR));
        return;
      }
      // 现在可以先跳到结果页
      cprov.setQuesSearching();
      NavigationHelper.pushNamed(RouteCollector.explanation, arguments: compressedPath);
      String token=sprov.user.token;
      Tuple2<int,QuesSearchRes?> res=await ContentWorker.searchQues(token:token,picPath: compressedPath);

      if(res.item1==ResultCode.SUCCESS){
        cprov.setQuesSearchDone(res.item2!);
        DBHandler.addQuesHistory(
          QuestionHistory(
            userId: sprov.user.id,
            imgPath: compressedPath,
            time: DateTime.now(),
          )
        );
      }else{
        cprov.setQuesSearchFailed();
        SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
      }
  }
  /*用于搜题失败后的再次尝试，只能在哪里调用*/
  static Future<void> executeSearchQuesAgain(String compressedPath) async{
    // 仅仅在结果页中使用
    cprov.setQuesSearching();
    String token=sprov.user.token;
    Tuple2<int,QuesSearchRes?> res=await ContentWorker.searchQues(token:token,picPath: compressedPath);
    if(res.item1==ResultCode.SUCCESS){
      cprov.setQuesSearchDone(res.item2!);
    }else{
      cprov.setQuesSearchFailed();
      SnackbarHelper.showToasterWithDesc(ResultCode.getDesc(res.item1));
    }
  }
}