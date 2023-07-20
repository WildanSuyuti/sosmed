import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/exception.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/data/models/param.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/features/user/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ResponseList<User>>> getAllUser(
      ListParam param) async {
    try {
      final result = await remoteDataSource.getAllUser(param);
      final entity = ResponseList<User>(
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
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDetail>> getUserDetail(String userId) async {
    try {
      final result = await remoteDataSource.getUserDetail(userId);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
