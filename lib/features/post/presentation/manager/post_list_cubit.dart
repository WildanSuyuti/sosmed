import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/core/local/local_data.dart';
import 'package:logique_test/features/commons/domain/entities/response_list.dart';
import 'package:logique_test/features/post/data/models/post_list_param.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/features/post/domain/use_cases/get_all_post_usecase.dart';

part 'post_list_state.dart';

@injectable
class PostListCubit extends Cubit<PostListState> {
  PostListCubit(this._useCase) : super(PostListInitial());

  final GetAllPostUseCase _useCase;

  Future<void> fetch({int page = 0, String? userId, String? tag}) async {
    if (page == 0) emit(PostListInitial());

    final result = await _useCase(
      PostListParam(userId: userId, tag: tag, page: page),
    );
    final likedPost = await getIt<LocalData>().postList ?? [];
    result.fold((failure) => emit(PostListError(failure: failure)), (response) {
      final data = response.data;
      if (page != 0 && _isPostListSuccess) {
        final exist = (state as PostListSuccess).response.data;
        data.insertAll(0, exist);
      }
      emit(
        PostListSuccess(
          response: response.copyWith(data: data),
          likedPost: likedPost,
        ),
      );
    });
  }

  bool get _isPostListSuccess => state is PostListSuccess;

  Future<void> searchPostByText(String text) async {
    if (_isPostListSuccess) {
      final existState = (state as PostListSuccess);
      final filtered = existState.response.data
          .where((element) => element.text?.contains(text) ?? false)
          .toList();
      emit(existState.copyWith(filteredPost: filtered));
    }
  }

  Future<void> clearSearch() async {
    if (_isPostListSuccess) {
      final existState = state as PostListSuccess;
      emit(existState.copyWith(filteredPost: []));
    }
  }

  Future<void> fetchFavorites() async {
    final result = await getIt<LocalData>().postList ?? [];
    emit(FavoriteSuccess(favorites: result));
  }

  Future<void> onTapLike(bool isLike, Post post) async =>
      isLike ? _unlike(post) : _like(post);

  Future<void> _like(Post post) async {
    final local = getIt<LocalData>();
    bool isExist = await local.isPostExist(post);
    if (!isExist) {
      await local.addPost(post);
      final likedPost = await local.postList ?? [];
      if (_isPostListSuccess) {
        final existState = (state as PostListSuccess);
        emit(existState.copyWith(likedPost: likedPost));
      } else if (state is FavoriteSuccess) {
        emit(FavoriteSuccess(favorites: likedPost));
      }
    }
  }

  Future<void> _unlike(Post post) async {
    final local = getIt<LocalData>();
    bool isExist = await local.isPostExist(post);
    if (isExist) {
      await local.removePost(post);
      final likedPost = await local.postList ?? [];
      if (_isPostListSuccess) {
        final existState = (state as PostListSuccess);
        emit(existState.copyWith(likedPost: likedPost));
      } else if (state is FavoriteSuccess) {
        emit(FavoriteSuccess(favorites: likedPost));
      }
    }
  }
}
