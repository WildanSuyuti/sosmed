import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_client.dart';

@lazySingleton
class ApiService {
  final DioClient client;

  ApiService(this.client);

  Options get _options => Options(
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'app-id': '64b746a2c537114d34a80b38'
        },
      );

  get(String path, {Map<String, dynamic>? param}) async {
    final result =
        await client.dio.get(path, options: _options, queryParameters: param);
    return result;
  }

  post(String path, Map<String, dynamic>? body) async {
    final result = await client.dio.post(path, options: _options, data: body);
    return result;
  }
}
