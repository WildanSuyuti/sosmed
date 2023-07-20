import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:logique_test/core/local/local_constants.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/features/user/data/models/user_model.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';

part 'post_model.g.dart';

@HiveType(typeId: LocalTypes.post)
class PostModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final int? likes;
  @HiveField(3)
  final List<String>? tags;
  @HiveField(4)
  final String? text;
  @HiveField(5)
  final DateTime? publishDate;
  @HiveField(6)
  final UserModel? owner;

  const PostModel({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  factory PostModel.fromEntity(Post post) => PostModel(
        id: post.id,
        image: post.image,
        likes: post.likes,
        tags: post.tags,
        text: post.text,
        publishDate: post.publishDate,
        owner: post.owner == null ? null : UserModel.fromEntity(post.owner!),
      );

  Post toEntity() => Post(
        id: id,
        image: image,
        likes: likes,
        tags: tags,
        text: text,
        publishDate: publishDate,
        owner: owner?.toEntity(),
      );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      image: json['image'],
      likes: json['likes'],
      tags: json['tags'] == null ? null : List.from(json['tags']),
      text: json['text'],
      publishDate: json['publishDate'] == null
          ? null
          : '${json['publishDate']}'.readIsoDate(),
      owner: json['owner'] != null ? UserModel.fromJson(json['owner']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'likes': likes,
        'tags': tags,
        'text': text,
        'publishDate': publishDate,
        'owner': owner?.toJson(),
      };

  @override
  List<Object?> get props => [
        id,
        image,
        likes,
        tags,
        text,
        publishDate,
        owner,
      ];
}
