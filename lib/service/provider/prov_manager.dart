import 'package:easy_cse/domain/entity/persistence_kind/ques_history.dart';
import 'package:easy_cse/service/provider/chat/chat_session_prov.dart';
import 'package:easy_cse/service/provider/chat/chat_state_prov.dart';
import 'package:easy_cse/service/provider/ques/explanation_provider.dart';
import 'package:easy_cse/service/provider/note/note_prov.dart';
import 'package:easy_cse/service/provider/page_change_prov.dart';
import 'package:easy_cse/service/provider/ques/ques_history_prov.dart';
import 'package:easy_cse/service/provider/ques/question_prov.dart';
import 'package:easy_cse/service/provider/global/state_manager.dart';
import 'package:easy_cse/service/provider/user/veri_code_prov.dart';
import 'package:easy_cse/vault/style_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvManager {
  // global
  static late StateManagerProv stateProv;
  // user
  static late VeriCodeProv veriCodeProv;
  // chat
  static late ChatStateProv chatStateProv;
  static late ChatSessionProv chatSessionProv;
  // ques
  static late QuestionProv questionProv;
  static late ExplanationProv explanationProv;
  static late QuesHistoryProv quesHistoryProv;
  // note
  static late NoteProv noteProv;
  // page and ui
  static late PageChangeProv pageChangeProv;
  static late StyleProv styleProv;

  static void init(){
    // global
    stateProv = StateManagerProv();
    // user
    veriCodeProv = VeriCodeProv();
    // chat
    chatStateProv = ChatStateProv();
    chatSessionProv = ChatSessionProv();
    // ques
    questionProv = QuestionProv();
    explanationProv = ExplanationProv();
    quesHistoryProv = QuesHistoryProv();
    // note
    noteProv = NoteProv();
    // page and ui
    pageChangeProv = PageChangeProv();
    styleProv = StyleProv();
  }
  // 必须是List<SingleChildWidget>
  static List<SingleChildWidget> get getProvList{
    return [
      // global
      ChangeNotifierProvider(create: (context) => stateProv),
      // user
      ChangeNotifierProvider(create: (context) => veriCodeProv),
      // chat
      ChangeNotifierProvider(create: (context) => chatStateProv),
      ChangeNotifierProvider(create: (context) => chatSessionProv),
      // ques
      ChangeNotifierProvider(create: (context) => questionProv),
      ChangeNotifierProvider(create: (context) => explanationProv),
      ChangeNotifierProvider(create: (context) => quesHistoryProv),
      // note
      ChangeNotifierProvider(create: (context) => noteProv),
      // page and ui
      ChangeNotifierProvider(create: (context) => pageChangeProv),
      ChangeNotifierProvider(create: (context) => styleProv),
    ];
  }
}