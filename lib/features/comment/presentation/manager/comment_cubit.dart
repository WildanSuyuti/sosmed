import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/data/models/comment_list_param.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/comment/domain/use_cases/create_comment_use_case.dart';
import 'package:logique_test/features/comment/domain/use_cases/get_all_comment_use_case.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';

part 'comment_state.dart';

@injectable
class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this._useCase, this._createUseCase) : super(CommentInitial());

  final GetAllCommentUseCase _useCase;
  final CreateCommentUseCase _createUseCase;

  Future<void> fetch({int page = 0, String? userId, String? postId}) async {
    if (page == 0) emit(CommentInitial());
    final result = await _useCase(
      CommentListParam(userId: userId, postId: postId, page: page),
    );
    result.fold((failure) => emit(CommentError(failure: failure)), (response) {
      final data = response.data;
      if (page != 0 && state is CommentSuccess) {
        final exist = (state as CommentSuccess).response.data;
        data.insertAll(0, exist);
      }
      emit(CommentSuccess(response: response.copyWith(data: data)));
    });
  }

  Future<void> createComment(CommentBody body) async {
    if (state is CommentSuccess) {
      final exist = (state as CommentSuccess).response;
      emit(CommentInitial(isFromCreate: true, existData: exist));
      final result = await _createUseCase(body);
      result.fold(
        (failure) => emit(
          CommentError(
            existData: exist,
            isFromCreate: true,
            failure: failure,
          ),
        ),
        (response) {
          final data = exist.data;
          data.insert(0, response);
          emit(
            CommentSuccess(
              response: exist.copyWith(data: data),
              isFromCreate: true,
            ),
          );
        },
      );
    }
  }
}
