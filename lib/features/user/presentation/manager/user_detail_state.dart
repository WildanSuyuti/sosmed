part of 'user_detail_cubit.dart';

@immutable
abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailSuccess extends UserDetailState {
  final UserDetail response;
  final List<String> friends;

  UserDetailSuccess({required this.response, this.friends = const <String>[]});

  UserDetailSuccess copyWith({
    UserDetail? response,
    List<String>? friends,
  }) {
    return UserDetailSuccess(
      response: response ?? this.response,
      friends: friends ?? this.friends,
    );
  }
}

class UserDetailError extends UserDetailState {
  final Failure failure;

  UserDetailError({required this.failure});
}
