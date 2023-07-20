import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/comment/data/models/comment_body.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/comment/presentation/manager/comment_cubit.dart';
import 'package:logique_test/features/comment/presentation/pages/comment_list_shimmer_ui.dart';
import 'package:logique_test/features/comment/presentation/widgets/comment_item_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/failure_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/shared/extensions/failure_ext.dart';
import 'package:logique_test/shared/utils/dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentListUI extends StatefulWidget {
  final Post post;

  const CommentListUI({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentListUI> createState() => _CommentListUIState();
}

class _CommentListUIState extends State<CommentListUI> {
  late RefreshController _refreshController;
  late CommentCubit _cubit;
  late bool _isAvailableNext;
  late int _page;
  late TextEditingController _controller;

  @override
  void initState() {
    _refreshController = RefreshController();
    _cubit = getIt();
    _isAvailableNext = false;
    _page = 0;
    _fetch(page: 0);
    _controller = TextEditingController();
    super.initState();
  }

  _fetch({int? page}) => _cubit.fetch(
        postId: widget.post.id,
        page: page ?? _page,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const RoundedContainer(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                height: 5,
                width: 50,
                padding: EdgeInsets.all(16),
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: BlocConsumer<CommentCubit, CommentState>(
                bloc: _cubit,
                listener: (_, state) {
                  if (state is CommentError && state.isFromCreate) {
                    final failure = state.failure;
                    showMyDialog(context, failure.title, failure.message);
                  }
                  if (state is CommentSuccess) {
                    if (!state.isFromCreate) {
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
                    }
                  }
                },
                builder: (_, state) {
                  if (state is CommentInitial) {
                    if (state.isFromCreate) {
                      return _mainUI(state.existData?.data ?? []);
                    } else {
                      return const CommentListShimmerUI();
                    }
                  } else if (state is CommentSuccess) {
                    final items = state.response.data;
                    if (items.isEmpty) {
                      return const Center(
                        child: Text('There are no comments on this post yet'),
                      );
                    } else {
                      return _mainUI(items);
                    }
                  } else if (state is CommentError) {
                    if (state.isFromCreate) {
                      return _mainUI(state.existData?.data ?? []);
                    } else {
                      return FailureUI.showErrorMessage(
                        failure: state.failure,
                        onRetry: () => _fetch(page: 0),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            RoundedContainer(
              width: MediaQuery.of(context).size.width,
              height: kToolbarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              border: Border.all(color: Colors.grey),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Add Comment',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onSubmitted: (text) {
                  _cubit.createComment(
                    CommentBody(
                      owner: '${widget.post.owner?.id}',
                      post: '${widget.post.id}',
                      message: text,
                    ),
                  );
                  _controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _mainUI(List<Comment> items) {
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
            return CommentItemUI(comment: item);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    _refreshController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
