import 'package:logique_test/features/commons/data/models/param.dart';

class CommentListParam extends ListParam {
  final String? postId;
  final String? userId;

  CommentListParam({this.postId, this.userId, int? page, int? limit})
      : super(page: page, limit: limit);

  String get path {
    if (userId != null) {
      return 'user/$userId/comment';
    } else if (postId != null) {
      return 'post/$postId/comment';
    }
    return 'comment';
  }
}
