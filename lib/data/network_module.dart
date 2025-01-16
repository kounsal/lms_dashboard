import 'package:dio/dio.dart';

class NetworkModule {
  static final NetworkModule _instance = NetworkModule._internal();
  late Dio dio;

  factory NetworkModule() {
    return _instance;
  }

  NetworkModule._internal() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://lms-backend-gc2i.onrender.com/api',
          connectTimeout: Duration(milliseconds: 5000),
          receiveTimeout: Duration(milliseconds: 3000),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
    );
  }

  Dio getClient() {
    return dio;
  }
}
