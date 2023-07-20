import 'package:logique_test/features/comment/data/models/comment_model.dart';
import 'package:logique_test/features/post/data/models/post_model.dart';
import 'package:logique_test/features/user/data/models/user_model.dart';

class ResponseListModel<Model> {
  final int page;
  final int limit;
  final int total;
  final List<Model> data;

  ResponseListModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.data,
  });

  ResponseListModel<Model> copyWith({
    int? page,
    int? limit,
    int? total,
    List<Model>? data,
  }) {
    return ResponseListModel(
      data: data ?? this.data,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      total: total ?? this.total,
    );
  }

  factory ResponseListModel.fromJson(Map<String, dynamic> json) {
    return ResponseListModel(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      data: _data(json['data']),
    );
  }

  static List<T> _data<T>(dynamic jsonData) {
    switch (T) {
      case UserModel:
        return List<UserModel>.from(
            jsonData.map((json) => UserModel.fromJson(json))) as List<T>;
      case PostModel:
        return List<PostModel>.from(
            jsonData.map((json) => PostModel.fromJson(json))) as List<T>;
      case CommentModel:
        return List<CommentModel>.from(
            jsonData.map((json) => CommentModel.fromJson(json))) as List<T>;

      default:
        throw UnsupportedError('Please add $T Model inside ResponseList class');
    }
  }
}
