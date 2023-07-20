import 'package:logique_test/features/commons/data/models/param.dart';

class PostListParam extends ListParam {
  final String? tag;
  final String? userId;

  PostListParam({this.tag, this.userId, int? page, int? limit})
      : super(page: page, limit: limit);

  String get path {
    if (userId != null) {
      return 'user/$userId/post';
    } else if (tag != null) {
      return 'tag/$tag/post';
    }
    return 'post';
  }
}
