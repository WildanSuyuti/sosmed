import 'package:logique_test/features/user/domain/entities/user.dart';

class Post {
  final String? id;
  final String? image;
  final int? likes;
  final List<String>? tags;
  final String? text;
  final DateTime? publishDate;
  final User? owner;

  Post({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });
}
