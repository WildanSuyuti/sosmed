import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/commons/presentation/widgets/failure_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/my_appbar.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/post/presentation/manager/post_list_cubit.dart';
import 'package:logique_test/features/post/presentation/widgets/post_item_ui.dart';
import 'package:logique_test/features/post/presentation/widgets/post_list_shimmer_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage>
    with AutomaticKeepAliveClientMixin {
  late RefreshController _refreshController;
  late PostListCubit _cubit;
  late bool _isAvailableNext;
  late int _page;
  String? _tag;

  @override
  void initState() {
    _refreshController = RefreshController();
    _cubit = getIt();
    _isAvailableNext = false;
    _page = 0;
    _cubit.fetch(page: _page);
    super.initState();
  }

  _fetch({int? page}) => _cubit.fetch(tag: _tag, page: page ?? _page);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(title: 'Post'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_tag != null) _buildRemoveTagUI(),
            Expanded(
              child: BlocConsumer<PostListCubit, PostListState>(
                bloc: _cubit,
                listener: (_, state) {
                  if (state is PostListSuccess) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                    setState(() {
                      final response = state.response;
                      _page = response.page;
                      int lastPage = (response.total / response.limit).floor();
                      _isAvailableNext = response.page < lastPage;
                      if (_isAvailableNext) _page++;
                    });
                  }
                },
                builder: (_, state) {
                  if (state is PostListInitial) {
                    return const PostListShimmerUI();
                  } else if (state is PostListSuccess) {
                    final items = state.response.data;
                    final likes = state.likedPost;
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: SmartRefresher(
                        enablePullUp: _isAvailableNext,
                        controller: _refreshController,
                        onRefresh: () => _fetch(page: 0),
                        onLoading: () => _fetch(),
                        footer: const ClassicFooter(),
                        child: ListView.builder(
                          itemCount: items.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            final item = items[i];
                            final isLike = likes
                                .where((element) => element.id == item.id)
                                .isNotEmpty;
                            return PostItemUI(
                              isLike: isLike,
                              post: item,
                              onTagPressed: (tag) {
                                setState(() => _tag = tag);
                                _fetch(page: 0);
                              },
                              onTapLike: () => _cubit.onTapLike(isLike, item),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is PostListError) {
                    return FailureUI.showErrorMessage(
                      failure: state.failure,
                      onRetry: () => _fetch(page: 0),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveTagUI() => GestureDetector(
        onTap: () {
          setState(() => _tag = null);
          _fetch(page: 0);
        },
        child: Stack(
          children: [
            RoundedContainer(
              margin: const EdgeInsets.only(bottom: 16, top: 4, right: 8),
              radius: 20,
              color: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                _tag!,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const Positioned(
              right: 0,
              child: RoundedContainer(
                radius: 20,
                padding: EdgeInsets.all(4),
                color: Colors.blueGrey,
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _cubit.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
