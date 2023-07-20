import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/core/local/local_data.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/features/user/domain/use_cases/get_user_detail_usecase.dart';

part 'user_detail_state.dart';

@injectable
class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._useCase) : super(UserDetailInitial());

  final GetUserDetailUseCase _useCase;

  Future<void> fetch(String userId) async {
    emit(UserDetailInitial());
    final result = await _useCase(userId);
    final friends = await getIt<LocalData>().userIds ?? [];
    result.fold((failure) => emit(UserDetailError(failure: failure)),
        (response) {
      emit(UserDetailSuccess(response: response, friends: friends));
    });
  }

  bool get _isSuccess => state is UserDetailSuccess;

  Future<void> onTapFollow(bool isFollowed, String id) async =>
      isFollowed ? _unfollow(id) : _follow(id);

  Future<void> _follow(String id) async {
    final local = getIt<LocalData>();
    bool isExist = await local.isUserIdExist(id);
    if (!isExist) {
      await local.addUserId(id);
      final friends = await local.userIds ?? [];
      if (_isSuccess) {
        final existState = (state as UserDetailSuccess);
        emit(existState.copyWith(friends: friends));
      }
    }
  }

  Future<void> _unfollow(String id) async {
    final local = getIt<LocalData>();
    bool isExist = await local.isUserIdExist(id);
    if (isExist) {
      await local.removeUserId(id);
      final friends = await local.userIds ?? [];
      if (_isSuccess) {
        final existState = (state as UserDetailSuccess);
        emit(existState.copyWith(friends: friends));
      }
    }
  }
}
