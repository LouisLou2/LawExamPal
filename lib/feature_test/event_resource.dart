import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
/*服务器总是会携带charset=utf-8  方便dio进行自动解码*/
final dio = Dio();
const String url = 'http://localhost:8099';  // Flask服务的URL
const String for_stream='/stream';
const String for_json='/json';
const String chat='/chat';


Future<void> test_stream() async {
  // 发送GET请求，并获取数据流
  Response<ResponseBody> response = await dio.get<ResponseBody>(
    url+for_stream,
    options: Options(
      responseType: ResponseType.stream,
      headers: {"Accept": "text/plain; charset=utf-8"},
    ),
  );

  // 创建StreamTransformer并将utf8.decoder作为转换器
  var streamTransformer = StreamTransformer<Uint8List,dynamic>.fromHandlers(
    handleData: (data, sink) {
      var string = utf8.decode(data, allowMalformed: true);
      sink.add(string);
    },
  );

  response.data?.stream.transform(streamTransformer).listen(
        (data) {
      print(data);
    },
    onDone: () {
      print('Stream has ended.');
    },
    onError: (e) {
      print("Error: $e");
    },
  );
}
Future<void> test_json()async{
  try {
    Response response = await dio.post(
      url+chat,
      data: {
        'id': 10001,
        'ques': '你好',
      },
      // queryParameters: {
      //   'id': 10001,
      //   'ques': '你好',
      // },
      options: Options(
        responseType: ResponseType.json, // 指定响应类型为纯文本
      ),
    );
    final contentType = response.headers.map['content-type'];
    final data=response.data;
    // 当响应为纯文本时，确保使用 UTF-8 解码
    // final responseBody = utf8.decode(data.toString().codeUnits);
    // 将解码后的字符串解析为 JSON
    // final jsonData = json.decode(data);
    // print('not any decode, raw data:');
    print(data);
    //print('utf-8 and json decoded:');
    //print(jsonData);
  } catch (e) {
    print("Caught error: $e");
  }
}
Future<void> test_json_byte()async{
  try {
    Response response = await dio.get(
      url+for_json,
      options: Options(
        responseType: ResponseType.bytes, // 指定响应类型为纯文本
      ),
    );
    final data=response.data;
    // 当响应为纯文本时，确保使用 UTF-8 解码
    final responseBody = utf8.decode(data);
    // 将解码后的字符串解析为 JSON
    final jsonData = json.decode(responseBody);
    //print('not any decode, raw data:');
    //print(data);
    //print('utf-8 and json decoded:');
    //print(jsonData);
  } catch (e) {
    print("Caught error: $e");
  }
}
void main() async {
  // 测试发现，test_json和test_json_byte的结果几乎是一样的速度
  await test_json();
}