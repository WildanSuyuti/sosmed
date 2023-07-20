part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {
  final bool isFromCreate;
  final ResponseList<Comment>? existData;

  CommentInitial({this.isFromCreate = false, this.existData});
}

class CommentSuccess extends CommentState {
  final bool isFromCreate;
  final ResponseList<Comment> response;

  CommentSuccess({required this.response, this.isFromCreate = false});
}

class CommentError extends CommentState {
  final ResponseList<Comment>? existData;
  final bool isFromCreate;
  final Failure failure;

  CommentError({
    required this.failure,
    this.existData,
    this.isFromCreate = false,
  });
}
