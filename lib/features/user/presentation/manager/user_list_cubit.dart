import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/features/commons/data/models/param.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/domain/use_cases/get_all_user_usecase.dart';

part 'user_list_state.dart';

@injectable
class UserListCubit extends Cubit<UserListState> {
  UserListCubit(this._useCase) : super(UserListInitial());

  final GetAllUserUseCase _useCase;

  Future<void> fetch([int page = 0]) async {
    if (page == 0) emit(UserListInitial());

    final result = await _useCase(ListParam(page: page));

    result.fold((failure) => emit(UserListError(failure: failure)), (response) {
      final data = response.data;
      if (page != 0 && state is UserListSuccess) {
        final exist = (state as UserListSuccess).response.data;
        data.insertAll(0, exist);
      }
      emit(UserListSuccess(response: response.copyWith(data: data)));
    });
  }
}
