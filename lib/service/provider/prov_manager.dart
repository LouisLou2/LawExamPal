import 'package:easy_cse/service/provider/chat_state_prov.dart';
import 'package:easy_cse/service/provider/page_change_prov.dart';
import 'package:easy_cse/service/provider/user_info_prov.dart';
import 'package:easy_cse/vault/style_provider.dart';
import 'package:provider/provider.dart';

class ProvManager {
  static late PageChangeProv pageChangeProvider;
  static late StyleProv styleProvider;
  static late UserInfoProv userInfoProv;
  static late ChatStateProv chatStateProv;
  // static late Map<String,ChangeNotifier> providerMap;
  static void init(){
    pageChangeProvider = PageChangeProv();
    styleProvider = StyleProv();
    userInfoProv = UserInfoProv();
    chatStateProv = ChatStateProv();
  }
  static List<ChangeNotifierProvider> get getProvList{
    return [
      ChangeNotifierProvider.value(value: pageChangeProvider),
      ChangeNotifierProvider.value(value: styleProvider),
      ChangeNotifierProvider.value(value: userInfoProv),
      ChangeNotifierProvider.value(value: chatStateProv),
    ];
  }
}