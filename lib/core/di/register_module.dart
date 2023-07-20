import 'package:logique_test/core/local/local_data.dart';
import 'package:logique_test/features/post/data/models/post_model.dart';
import 'package:logique_test/features/user/data/models/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/network/dio_client.dart';
import 'package:m_toast/m_toast.dart';
import 'package:hive/hive.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  DioClient get client => DioClient('https://dummyapi.io/data/v1/');

  @lazySingleton
  ShowMToast get toast => ShowMToast();

  @preResolve
  @lazySingleton
  Future<Box> get openBox async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDir.path)
      ..registerAdapter(PostModelAdapter())
      ..registerAdapter(UserModelAdapter());
    return Hive.openBox('logique-test');
  }

  @lazySingleton
  LocalData get localData => LocalData();
}
