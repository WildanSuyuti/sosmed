import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:logique_test/features/commons/presentation/widgets/my_appbar.dart';
import 'package:logique_test/features/post/presentation/manager/post_list_cubit.dart';
import 'package:logique_test/features/post/presentation/widgets/post_item_ui.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  late PostListCubit _cubit;

  @override
  void initState() {
    _cubit = getIt();
    _cubit.fetchFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(title: 'Favorites'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<PostListCubit, PostListState>(
          bloc: _cubit,
          builder: (_, state) {
            if (state is FavoriteSuccess) {
              final items = state.favorites;
              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'Favorites is still empty',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                );
              } else {
                return ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      return PostItemUI(
                        isLike: true,
                        post: items[i],
                        onTapLike: () => _cubit.onTapLike(true, items[i]),
                      );
                    },
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}
