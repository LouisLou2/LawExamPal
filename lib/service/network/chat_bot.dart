import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/constant/resp_code_enum.dart';
import 'package:easy_cse/domain/entity/response_body.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';
import 'package:easy_cse/service/network/network_worker.dart';
import 'package:easy_cse/state/state_manager.dart';

class ChatBot{
  static final Dio bot=NetWorkWorker.chatWorker;
  static const bool debug=true;
  static late CancelToken _cancelToken;
  static void init(){

  }
  static void cancelQuery(){
    if(!_cancelToken.isCancelled){
      _cancelToken.cancel(['User Canceled it']);
    }
  }
  static Future<String?> getAnswer(String query) async{
    _cancelToken=CancelToken();
    // dio请求，向localhost请求
    try {
      Response response = await bot.post(
        NetworkPathCollector.chat,
        data: {
          'id': StateManager.user.userId,
          'ques': query,
        },
        options: Options(
          responseType: ResponseType.json, // 指定响应类型为纯文本
        ),
        cancelToken: _cancelToken,
      );
      final data=response.data;
      RespBody respBody=RespBody.fromJson(data);
      if(respBody.code!=RespCode.SUCCESS){
        return null;
      }
      return respBody.data as String;
    } on DioException catch (e) {
      if(e.type == DioExceptionType.cancel){
        return AppStrings.cancelQuery;
      }
      return """$e\n### 1. 制作待办事宜 `Todo` 列表
- [x] 🎉 通常 `Markdown` 解析器自带的基本功能；
- [x] 🍀 支持**流程图**、**甘特图**、**时序图**、**任务列表**；
- [x] 🏁 支持粘贴 HTML 自动转换为 Markdown；
- [x] 💃🏻 支持插入原生 Emoji、设置常用表情列表；
- [x] 🚑 支持编辑内容保存**本地存储**，防止意外丢失；
- [x] 📝 支持**实时预览**，主窗口大小拖拽，字符计数；
- [x] 🛠 支持常用快捷键(**Tab**)，及代码块添加复制
- [x] ✨ 支持**导出**携带样式的 PDF、PNG、JPEG 等；
- [x] ✨ 升级 Vditor，新增对 `echarts` 图表的支持；
- [x] 👏 支持检查并格式化 Markdown 语法，使其专业；
- [x] 🦑 支持五线谱、及[部分站点、视频、音频解析](https://github.com/b3log/vditor/issues/117?utm_source=hacpai.com#issuecomment-526986052)；
- [x] 🌟 增加对**所见即所得**编辑模式的支持(`⌘-⇧-M`)；""";
    } finally{}
  }
}