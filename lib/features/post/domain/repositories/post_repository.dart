import 'package:dartz/dartz.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/post/data/models/post_list_param.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, ResponseList<Post>>> getAllPost(PostListParam param);
}
