import 'package:dio/dio.dart' as dio;
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/network/api_service.dart';
import 'package:logique_test/features/commons/data/models/response_list_model.dart';
import 'package:logique_test/features/post/data/models/post_list_param.dart';
import 'package:logique_test/features/post/data/models/post_model.dart';
import 'package:logique_test/shared/extensions/dio_extension.dart';

abstract class PostRemoteDataSource {
  Future<ResponseListModel<PostModel>> getAllPost(PostListParam param);
}

@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiService _service;

  PostRemoteDataSourceImpl(this._service);

  @override
  Future<ResponseListModel<PostModel>> getAllPost(PostListParam param) async {
    try {
      final response = await _service.get(param.path, param: param.toJson());
      return ResponseListModel<PostModel>.fromJson(response.data);
    } on dio.DioException catch (exc) {
      if (exc.isNoConnectionError) {
        throw NetworkException();
      } else if (exc.response?.data != null) {
        throw ServerException(exc.response?.data['error']);
      } else {
        rethrow;
      }
    }
  }
}
