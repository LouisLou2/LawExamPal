import 'package:easy_cse/service/provider/page_change_provider.dart';
import 'package:easy_cse/vault/style_provider.dart';

class ProviderManager {
  static late PageChangeProvider pageChangeProvider;
  static late StyleProvider styleProvider;
  // static late Map<String,ChangeNotifier> providerMap;
  static void init(){
    pageChangeProvider = PageChangeProvider();
    styleProvider = StyleProvider();
  }
}