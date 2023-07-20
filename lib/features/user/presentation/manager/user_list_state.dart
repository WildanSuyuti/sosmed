part of 'user_list_cubit.dart';

@immutable
abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListSuccess extends UserListState {
  final ResponseList<User> response;

  UserListSuccess({required this.response});
}

class UserListError extends UserListState {
  final Failure failure;

  UserListError({required this.failure});
}
