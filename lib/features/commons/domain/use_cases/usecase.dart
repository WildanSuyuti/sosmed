import 'package:dartz/dartz.dart';
import 'package:logique_test/core/error/failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}
