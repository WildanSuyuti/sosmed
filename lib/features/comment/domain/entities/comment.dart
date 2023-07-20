import 'package:logique_test/features/user/domain/entities/user.dart';

class Comment {
  final String? id;
  final String? message;
  final User? owner;
  final String? postId;
  final DateTime? publishDate;

  Comment({this.id, this.message, this.owner, this.postId, this.publishDate});
}
