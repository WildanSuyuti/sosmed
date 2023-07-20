import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logique_test/features/home/presentation/pages/home_page.dart';
import 'package:logique_test/features/user/presentation/pages/user_detail_page.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.kRoute,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black)),
      ),
      routes: {
        HomePage.kRoute: (context) => const HomePage(),
        UserDetailPage.kRoute: (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          return UserDetailPage(
            arguments: arguments as UserDetailArguments,
          );
        },
      },
    );
  }
}
