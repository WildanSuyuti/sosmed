part of 'post_list_cubit.dart';

@immutable
abstract class PostListState {}

class PostListInitial extends PostListState {}

class PostListSuccess extends PostListState {
  final ResponseList<Post> response;
  final List<Post> likedPost;
  final List<Post> filteredPost;

  PostListSuccess({
    required this.response,
    required this.likedPost,
    this.filteredPost = const <Post>[],
  });

  PostListSuccess copyWith({
    ResponseList<Post>? response,
    List<Post>? likedPost,
    List<Post>? filteredPost,
  }) {
    return PostListSuccess(
      response: response ?? this.response,
      likedPost: likedPost ?? this.likedPost,
      filteredPost: filteredPost ?? this.filteredPost,
    );
  }
}

class FavoriteSuccess extends PostListState {
  final List<Post> favorites;

  FavoriteSuccess({required this.favorites});
}

class PostListError extends PostListState {
  final Failure failure;

  PostListError({required this.failure});
}
