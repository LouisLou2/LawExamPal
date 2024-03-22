import 'package:dio/dio.dart';
import 'package:easy_cse/service/network/network_route_collector.dart';

class NetWorkWorker {
  static Duration defaultTimeout = const Duration(milliseconds: 10000);
  static Duration longerTimeout = const Duration(milliseconds: 30000);
  // 默认的Dio实例
  static final Dio _basicDio = Dio(
    BaseOptions(
      baseUrl: NetworkPathCollector.host,
      connectTimeout: defaultTimeout,
      receiveTimeout: defaultTimeout,
    ),
  );// 懒加载

  // 专门用于聊天的Dio实例，因为聊天的请求可能会有不同的超时时间(longer)或者host
  static Dio? _chatDio;// 懒加载

  static Dio get normalWorker => _basicDio;
  static Dio get chatWorker{
    _chatDio ??= Dio(
      BaseOptions(
        baseUrl: NetworkPathCollector.host,
        connectTimeout: defaultTimeout,
        receiveTimeout: longerTimeout,
      ),
    );
    return _chatDio!;
  }

  Future<void> fetch() async {
    // Fetch data from network
  }
}