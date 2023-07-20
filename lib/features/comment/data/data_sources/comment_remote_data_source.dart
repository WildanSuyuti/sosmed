import 'package:dio/dio.dart' as dio;
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/network/api_service.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/data/models/comment_list_param.dart';
import 'package:logique_test/features/comment/data/models/comment_model.dart';
import 'package:logique_test/features/commons/data/models/response_list_model.dart';
import 'package:logique_test/shared/extensions/dio_extension.dart';

abstract class CommentRemoteDataSource {
  Future<ResponseListModel<CommentModel>> getAllComment(CommentListParam param);

  Future<CommentModel> createComment(CommentBody body);
}

@LazySingleton(as: CommentRemoteDataSource)
class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final ApiService _service;

  CommentRemoteDataSourceImpl(this._service);

  @override
  Future<ResponseListModel<CommentModel>> getAllComment(
      CommentListParam param) async {
    try {
      final response = await _service.get(param.path, param: param.toJson());
      return ResponseListModel<CommentModel>.fromJson(response.data);
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

  @override
  Future<CommentModel> createComment(CommentBody body) async {
    try {
      final response = await _service.post('comment/create', body.toJson());
      return CommentModel.fromJson(response.data);
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
