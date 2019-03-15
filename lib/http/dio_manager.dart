import 'dart:io';

import 'package:dio/dio.dart';

class DioManager {
  Dio _dio;

  DioManager._internal() {
    _dio = new Dio();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
  }

  static DioManager singleton = DioManager._internal();

  factory DioManager() => singleton;

  get dio {
    return _dio;
  }
}
