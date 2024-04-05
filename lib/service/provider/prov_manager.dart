import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/service/provider/chat_state_prov.dart';
import 'package:easy_cse/service/provider/content_provider.dart';
import 'package:easy_cse/service/provider/note_prov.dart';
import 'package:easy_cse/service/provider/page_change_prov.dart';
import 'package:easy_cse/service/provider/ques_history_prov.dart';
import 'package:easy_cse/service/provider/question_prov.dart';
import 'package:easy_cse/service/provider/state_manager.dart';
import 'package:easy_cse/service/provider/veri_code_prov.dart';
import 'package:easy_cse/vault/style_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvManager {
  static late PageChangeProv pageChangeProv;
  static late StyleProv styleProv;
  static late ChatStateProv chatStateProv;
  static late QuestionProv questionProv;
  static late VeriCodeProv veriCodeProv;
  static late StateManagerProv stateProv;
  static late ContentProv contentProv;
  static late QuesHistoryProv quesHistoryProv;
  static late NoteProv noteProv;

  static void init(){
    pageChangeProv = PageChangeProv();
    styleProv = StyleProv();
    chatStateProv = ChatStateProv();
    questionProv = QuestionProv();
    veriCodeProv = VeriCodeProv();
    stateProv = StateManagerProv();
    contentProv = ContentProv();
    quesHistoryProv = QuesHistoryProv();
    noteProv = NoteProv();
  }
  // 必须是List<SingleChildWidget>
  static List<SingleChildWidget> get getProvList{
    return [
      ChangeNotifierProvider.value(value: pageChangeProv),
      ChangeNotifierProvider.value(value: styleProv),
      ChangeNotifierProvider.value(value: stateProv),
      ChangeNotifierProvider.value(value: chatStateProv),
      ChangeNotifierProvider.value(value: questionProv),
      ChangeNotifierProvider.value(value: veriCodeProv),
      ChangeNotifierProvider.value(value: contentProv),
      ChangeNotifierProvider.value(value: quesHistoryProv),
      ChangeNotifierProvider.value(value: noteProv),
    ];
  }
}