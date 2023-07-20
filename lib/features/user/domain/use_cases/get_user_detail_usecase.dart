import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/domain/use_cases/usecase.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/features/user/domain/repositories/user_repository.dart';

@injectable
class GetUserDetailUseCase extends UseCase<UserDetail, String> {
  final UserRepository _repository;

  GetUserDetailUseCase(this._repository);

  @override
  Future<Either<Failure, UserDetail>> call(String param) {
    return _repository.getUserDetail(param);
  }
}
