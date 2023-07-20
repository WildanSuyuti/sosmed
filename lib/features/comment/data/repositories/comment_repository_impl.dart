import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/comment/data/data_sources/comment_remote_data_source.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/data/models/comment_list_param.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/comment/domain/repositories/comment_repository.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ResponseList<Comment>>> getAllComment(
      CommentListParam param) async {
    try {
      final result = await remoteDataSource.getAllComment(param);
      final entity = ResponseList<Comment>(
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

  @override
  Future<Either<Failure, Comment>> createComment(CommentBody body) async {
    try {
      final result = await remoteDataSource.createComment(body);
      return Right(result.toEntity());
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
