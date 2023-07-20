import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/data/models/param.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/commons/domain/use_cases/usecase.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/domain/repositories/user_repository.dart';

@injectable
class GetAllUserUseCase extends UseCase<ResponseList<User>, ListParam> {
  final UserRepository repository;

  GetAllUserUseCase(this.repository);

  @override
  Future<Either<Failure, ResponseList<User>>> call(ListParam param) {
    return repository.getAllUser(param);
  }
}
