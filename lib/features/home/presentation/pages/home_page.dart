import 'package:flutter/material.dart';
import 'package:logique_test/features/post/presentation/pages/favorites_page.dart';
import 'package:logique_test/features/post/presentation/pages/post_list_page.dart';
import 'package:logique_test/features/user/presentation/pages/user_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const kRoute = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _index;
  late PageController _controller;

  @override
  void initState() {
    _index = 0;
    _controller = PageController();
    super.initState();
  }

  void _onTap(int index) {
    if (_index != index) {
      _controller.jumpToPage(index);
      setState(() => _index = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _controller,
          onPageChanged: _onTap,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: const Key('bottom_nav'),
          currentIndex: _index,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.blue[900]),
          unselectedLabelStyle: TextStyle(color: Colors.grey[300]),
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'post'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorite'),
          ],
          onTap: _onTap,
        ),
      ),
    );
  }

  List<Widget> get _pages =>
      const [UserListPage(), PostListPage(), FavoritesPage()];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
