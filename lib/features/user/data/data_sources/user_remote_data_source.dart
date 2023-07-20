import 'package:dio/dio.dart' as dio;
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/network/api_service.dart';
import 'package:logique_test/features/commons/data/models/param.dart';
import 'package:logique_test/features/commons/data/models/response_list_model.dart';
import 'package:logique_test/features/user/data/models/user_detail_model.dart';
import 'package:logique_test/features/user/data/models/user_model.dart';
import 'package:logique_test/shared/extensions/dio_extension.dart';

abstract class UserRemoteDataSource {
  Future<ResponseListModel<UserModel>> getAllUser(ListParam param);

  Future<UserDetailModel> getUserDetail(String userId);
}

@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService _service;

  UserRemoteDataSourceImpl(this._service);

  @override
  Future<ResponseListModel<UserModel>> getAllUser(ListParam param) async {
    try {
      final response = await _service.get('user', param: param.toJson());
      return ResponseListModel<UserModel>.fromJson(response.data);
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
  Future<UserDetailModel> getUserDetail(String userId) async {
    try {
      final response = await _service.get('user/$userId');
      return UserDetailModel.fromJson(response.data);
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
