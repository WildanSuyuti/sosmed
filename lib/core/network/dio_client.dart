import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final String baseUrl;

  DioClient(this.baseUrl);

  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
    );
    final dio = Dio(options);
    dio.interceptors.add(_loggingInterceptor());
    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint(
          "--> ${options.method} ${"${options.baseUrl}${options.path}"}");
      debugPrint('Headers:');
      options.headers.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint('queryParameters:');
      options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint("--> END ${options.method}");

      // Do something before request is sent
      debugPrint('\n'
          '-- headers --\n'
          '${options.headers.toString()} \n'
          '-- request --\n -->body'
          '${options.data} \n'
          '');

      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (response, handler) {
      // Do something with response data
      debugPrint('\n'
          'Response : ${response.requestOptions.uri} \n'
          '-- headers --\n'
          '${response.headers.toString()} \n'
          '-- response --\n'
          '${jsonEncode(response.data)} \n'
          '');

      return handler.next(response); // continue
    }, onError: (DioException exc, handler) {
      debugPrint("Response Error : ${exc.message}");
      // Do something with response error
      return handler.next(exc); //continue
    });
  }
}
