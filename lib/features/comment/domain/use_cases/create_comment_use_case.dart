import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/comment/domain/repositories/comment_repository.dart';
import 'package:logique_test/features/commons/domain/use_cases/usecase.dart';

@injectable
class CreateCommentUseCase extends UseCase<Comment, CommentBody> {
  final CommentRepository _repository;

  CreateCommentUseCase(this._repository);

  @override
  Future<Either<Failure, Comment>> call(CommentBody param) {
    return _repository.createComment(param);
  }
}
