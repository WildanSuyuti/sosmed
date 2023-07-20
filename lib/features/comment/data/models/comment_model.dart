import 'package:equatable/equatable.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/user/data/models/user_model.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';

class CommentModel extends Equatable {
  final String? id;
  final String? message;
  final UserModel? owner;
  final String? postId;
  final DateTime? publishDate;

  const CommentModel({
    this.id,
    this.message,
    this.owner,
    this.postId,
    this.publishDate,
  });

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      message: comment.message,
      owner:
          comment.owner == null ? null : UserModel.fromEntity(comment.owner!),
      postId: comment.postId,
      publishDate: comment.publishDate,
    );
  }

  Comment toEntity() => Comment(
        id: id,
        owner: owner?.toEntity(),
        message: message,
        publishDate: publishDate,
        postId: postId,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'owner': owner,
        'post': postId,
        'publishDate': publishDate,
      };

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        message: json['message'],
        owner: json['owner'] == null ? null : UserModel.fromJson(json['owner']),
        postId: json['post'],
        publishDate: json['publishDate'] == null
            ? null
            : '${json['publishDate']}'.readIsoDate(),
      );

  @override
  List<Object?> get props => [id, message, owner, postId, publishDate];
}
