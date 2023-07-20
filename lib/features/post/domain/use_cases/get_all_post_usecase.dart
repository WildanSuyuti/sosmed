import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/commons/domain/use_cases/usecase.dart';
import 'package:logique_test/features/post/data/models/post_list_param.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/features/post/domain/repositories/post_repository.dart';

@injectable
class GetAllPostUseCase extends UseCase<ResponseList<Post>, PostListParam> {
  final PostRepository _repository;

  GetAllPostUseCase(this._repository);

  @override
  Future<Either<Failure, ResponseList<Post>>> call(PostListParam param) {
    return _repository.getAllPost(param);
  }
}
