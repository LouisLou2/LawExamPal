import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final url = 'http://localhost:8099/stream';

  try {
    Response<ResponseBody> response = await dio.get<ResponseBody>(
      url,
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
  } catch (e) {
    print("Caught error: $e");
  }
}