import 'package:hive/hive.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/post/data/models/post_model.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'local_constants.dart';

class LocalData {
  Future<void> _setData<T>(String key, T value) async =>
      getIt<Box>().put(key, value);

  Future<T?> _getData<T>(String key, [T? defaultValue]) async =>
      getIt<Box>().get(key, defaultValue: defaultValue);

  Future<int> clear() async => getIt<Box>().clear();

  Future<void> close() async {
    if (getIt<Box>().isOpen) Hive.close();
  }

  Future<List<String>?> get userIds async {
    return await _getData(LocalKeys.userIds);
  }

  Future<void> _setUserIds(List<String> userIds) async {
    return await _setData(LocalKeys.userIds, userIds);
  }

  Future<void> addUserId(String userId) async {
    final exist = await userIds ?? <String>[];
    exist.add(userId);
    return await _setUserIds(exist);
  }

  Future<void> removeUserId(String userId) async {
    final exist = await userIds ?? [];
    exist.removeWhere((element) => element == userId);
    return await _setUserIds(exist);
  }

  Future<bool> isUserIdExist(String userId) async {
    final data = await userIds;
    return data?.where((element) => element == userId).isNotEmpty ?? false;
  }

  Future<List<Post>?> get postList async {
    final data = await _getData(LocalKeys.post);
    return List<Post>.from(data.map((e) => e.toEntity()));
  }

  Future<void> setPostList(List<Post> postList) async {
    return await _setData(
      LocalKeys.post,
      postList.map((e) => PostModel.fromEntity(e)).toList(),
    );
  }

  Future<void> addPost(Post post) async {
    final exist = await postList ?? <Post>[];
    exist.add(post);
    return await setPostList(exist);
  }

  Future<void> removePost(Post post) async {
    final exist = await postList ?? [];
    exist.removeWhere((element) => element.id == post.id);
    return await setPostList(exist);
  }

  Future<bool> isPostExist(Post post) async {
    final data = await postList;
    return data?.where((element) => element.id == post.id).isNotEmpty ?? false;
  }
}
