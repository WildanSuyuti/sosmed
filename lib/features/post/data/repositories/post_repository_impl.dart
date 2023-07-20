import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/post/data/data_sources/post_remote_data_source.dart';
import 'package:logique_test/features/post/data/models/post_list_param.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/features/post/domain/repositories/post_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ResponseList<Post>>> getAllPost(
      PostListParam param) async {
    try {
      final result = await remoteDataSource.getAllPost(param);
      final entity = ResponseList<Post>(
        page: result.page,
        total: result.total,
        limit: result.limit,
        data: result.data.map((e) => e.toEntity()).toList(),
      );
      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      debugPrint('UnknownFailure: $e');
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
