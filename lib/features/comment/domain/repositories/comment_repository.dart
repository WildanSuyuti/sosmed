import 'package:dartz/dartz.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/data/models/comment_list_param.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';

abstract class CommentRepository {
  Future<Either<Failure, ResponseList<Comment>>> getAllComment(
      CommentListParam param);

  Future<Either<Failure, Comment>> createComment(CommentBody body);
}
