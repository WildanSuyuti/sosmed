import 'package:dartz/dartz.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/data/models/param.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';

abstract class UserRepository {
  Future<Either<Failure, ResponseList<User>>> getAllUser(ListParam param);

  Future<Either<Failure, UserDetail>> getUserDetail(String userId);
}
