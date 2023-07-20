import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/commons/presentation/widgets/failure_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/shimmer_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/sliver_search_appbar.dart';
import 'package:logique_test/features/commons/presentation/widgets/underline_ui.dart';
import 'package:logique_test/features/post/presentation/manager/post_list_cubit.dart';
import 'package:logique_test/features/post/presentation/widgets/post_item_ui.dart';
import 'package:logique_test/features/post/presentation/widgets/post_list_shimmer_ui.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/features/user/presentation/manager/user_detail_cubit.dart';
import 'package:logique_test/features/user/presentation/widgets/user_detail_info_ui.dart';
import 'package:logique_test/shared/extensions/user_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserDetailArguments {
  final User user;

  UserDetailArguments({required this.user});
}

class UserDetailPage extends StatefulWidget {
  final UserDetailArguments arguments;

  const UserDetailPage({Key? key, required this.arguments}) : super(key: key);
  static const kRoute = '/user-detail';

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late UserDetailCubit _userDetailCubit;
  late PostListCubit _postListCubit;
  late RefreshController _refreshController;
  late FocusNode _node;
  late bool _isSearch;
  late bool _isAvailableNext;
  late int _page;

  @override
  void initState() {
    _userDetailCubit = getIt();
    _postListCubit = getIt();
    _refreshController = RefreshController();
    _fetchAll();
    _isSearch = false;
    _isAvailableNext = false;
    _page = 0;
    _node = FocusNode();
    super.initState();
  }

  _fetchAll() {
    _fetchUser();
    _fetchPost(page: 0);
  }

  _fetchUser() => _userDetailCubit.fetch(_id);

  _fetchPost({int? page}) {
    return _postListCubit.fetch(userId: _id, page: page ?? _page);
  }

  String get _id => '${widget.arguments.user.id}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SmartRefresher(
            enablePullUp: _isAvailableNext,
            controller: _refreshController,
            onRefresh: _fetchAll,
            onLoading: () => _fetchPost(),
            footer: const ClassicFooter(),
            child: CustomScrollView(
              slivers: [
                SliverSearchAppbar(
                  title: widget.arguments.user.name,
                  hint: 'Search in ${widget.arguments.user.name}',
                  isSearch: _isSearch,
                  onTapIcon: () => setState(() {
                    _isSearch = !_isSearch;
                    if (_isSearch) {
                      _node.requestFocus();
                    } else {
                      _postListCubit.clearSearch();
                    }
                  }),
                  node: _node,
                  onSubmitted: _postListCubit.searchPostByText,
                ),
                BlocConsumer<UserDetailCubit, UserDetailState>(
                  bloc: _userDetailCubit,
                  listener: (_, state) {
                    if (state is UserDetailSuccess) {
                      _refreshController.refreshCompleted();
                      _refreshController.loadComplete();
                    }
                  },
                  builder: (_, state) {
                    if (state is UserDetailInitial) {
                      return const SliverToBoxAdapter(
                        child: UserDetailInfoShimmerUI(),
                      );
                    } else if (state is UserDetailSuccess) {
                      final data = state.response;
                      final friends = state.friends;
                      final isFollowed = friends
                          .where((element) => element == data.id)
                          .isNotEmpty;
                      return UserDetailInfoUI(
                        isFollowed: isFollowed,
                        data: data,
                        onTapFollow: () {
                          if (data.id != null) {
                            _userDetailCubit.onTapFollow(isFollowed, data.id!);
                          }
                        },
                      );
                    } else if (state is UserDetailError) {
                      return SliverToBoxAdapter(
                        child: FailureUI.showErrorMessage(
                          failure: state.failure,
                          onRetry: _fetchUser,
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                BlocConsumer<PostListCubit, PostListState>(
                  bloc: _postListCubit,
                  listener: (_, state) {
                    if (state is PostListSuccess) {
                      _refreshController.refreshCompleted();
                      _refreshController.loadComplete();
                      setState(() {
                        final response = state.response;
                        _page = response.page;
                        int lastPage =
                            (response.total / response.limit).floor();
                        _isAvailableNext = response.page < lastPage;
                        if (_isAvailableNext) _page++;
                      });
                    } else if (state is PostListError) {
                      debugPrint('error: ${state.failure} ');
                    }
                  },
                  builder: (_, state) {
                    if (state is PostListInitial) {
                      return const SliverToBoxAdapter(
                          child: PostListShimmerUI());
                    } else if (state is PostListSuccess) {
                      final filtered = state.filteredPost;
                      final data = state.response.data;
                      final items = filtered.isNotEmpty ? filtered : data;
                      final likes = state.likedPost;
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: items.length,
                          (context, i) {
                            final item = items[i];
                            final isLike = likes
                                .where((element) => element.id == item.id)
                                .isNotEmpty;
                            return PostItemUI(
                              isLike: isLike,
                              post: item,
                              onTapLike: () {
                                _postListCubit.onTapLike(isLike, item);
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is PostListError) {
                      return SliverToBoxAdapter(
                        child: FailureUI.showErrorMessage(
                          failure: state.failure,
                          onRetry: () => _fetchPost(page: 0),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _userDetailCubit.close();
    _postListCubit.close();
    _node.dispose();
    super.dispose();
  }
}

class UserDetailInfoShimmerUI extends StatelessWidget {
  const UserDetailInfoShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.28;
    return ShimmerContainer(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Stack(
                  children: [
                    RoundedContainer(
                      margin: const EdgeInsets.only(bottom: 16),
                      radius: imageSize,
                      width: imageSize,
                      height: imageSize,
                      color: Colors.grey,
                      // border: Border.all(width: 5, color: Colors.blueGrey),
                    ),
                    const Positioned.fill(
                      bottom: 8,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RoundedContainer(
                          color: Colors.grey,
                          padding: EdgeInsets.all(8),
                          height: 30,
                          width: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedContainer(
                      radius: 6,
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 20,
                      color: Colors.grey,
                    ),
                    RoundedContainer(
                      radius: 6,
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 16,
                      color: Colors.grey,
                    ),
                    RoundedContainer(
                      radius: 6,
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 16,
                      color: Colors.grey,
                    ),
                    RoundedContainer(
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 16,
                      color: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            RoundedContainer(
              margin: const EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width * 0.4,
              height: 14,
              color: Colors.grey,
            ),
            RoundedContainer(
              margin: const EdgeInsets.only(bottom: 8),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 14,
              color: Colors.grey,
            ),
            UnderlineUI(margin: EdgeInsets.zero.copyWith(top: 8)),
          ],
        ),
      ),
    );
  }
}
