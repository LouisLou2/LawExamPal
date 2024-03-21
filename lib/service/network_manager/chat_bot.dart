import 'package:flutter_gemini/flutter_gemini.dart';

class ChatBot{
  static late Gemini bot;
  static const String apiKey='AIzaSyCWCybxMhI39Gf8CjdaS-BNxmIDrJY_7Uo';
  static const bool debug=true;
  static void init(){
    Gemini.init(apiKey: apiKey, enableDebugging: debug);
    bot=Gemini.instance;
  }
}