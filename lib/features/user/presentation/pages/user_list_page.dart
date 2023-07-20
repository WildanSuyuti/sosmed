import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/commons/presentation/widgets/failure_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/my_appbar.dart';
import 'package:logique_test/features/user/presentation/manager/user_list_cubit.dart';
import 'package:logique_test/features/user/presentation/pages/user_detail_page.dart';
import 'package:logique_test/features/user/presentation/widgets/user_item_ui.dart';
import 'package:logique_test/features/user/presentation/widgets/user_list_shimmer_ui.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with AutomaticKeepAliveClientMixin {
  late RefreshController _refreshController;
  late UserListCubit _cubit;
  late bool _isAvailableNext;
  late int _page;

  @override
  void initState() {
    _refreshController = RefreshController();
    _cubit = getIt();
    _isAvailableNext = false;
    _page = 0;
    _cubit.fetch(_page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(title: 'Users'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8).copyWith(bottom: 0),
        child: BlocConsumer<UserListCubit, UserListState>(
          bloc: _cubit,
          listener: (_, state) {
            if (state is UserListSuccess) {
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
            if (state is UserListInitial) {
              return const UserListShimmerUI();
            } else if (state is UserListSuccess) {
              final items = state.response.data;
              return ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: SmartRefresher(
                  enablePullUp: _isAvailableNext,
                  controller: _refreshController,
                  onRefresh: () => _cubit.fetch(),
                  onLoading: () => _cubit.fetch(_page),
                  footer: const ClassicFooter(),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) => UserItemUI(
                      user: items[i],
                      onTap: () => Navigator.pushNamed(
                          context, UserDetailPage.kRoute,
                          arguments: UserDetailArguments(user: items[i])),
                    ),
                  ),
                ),
              );
            } else if (state is UserListError) {
              return FailureUI.showErrorMessage(
                failure: state.failure,
                onRetry: () => _cubit.fetch(0),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
