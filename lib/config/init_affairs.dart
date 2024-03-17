import 'package:easy_cse/config/test_device.dart';
import 'package:easy_cse/service/provider/provider_manager.dart';

Future<void> initAsync() async{

}
void initMustBeforeRunApp(){
  ProviderManager.init();
  TestDeviceCollection.init();
}