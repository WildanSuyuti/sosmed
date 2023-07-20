import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/comment/data/models/comment_list_param.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/comment/domain/repositories/comment_repository.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/commons/domain/use_cases/usecase.dart';

@injectable
class GetAllCommentUseCase
    extends UseCase<ResponseList<Comment>, CommentListParam> {
  final CommentRepository _repository;

  GetAllCommentUseCase(this._repository);

  @override
  Future<Either<Failure, ResponseList<Comment>>> call(CommentListParam param) {
    return _repository.getAllComment(param);
  }
}
