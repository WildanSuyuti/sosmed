import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logique_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page', () {
    testWidgets(
      'tap on the bottom navigation bar item',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Finds the post BottomNavigationBarItem.
        final Finder post = find.byIcon(Icons.article);
        // Emulate a tap on the post menu
        await tester.tap(post);
        // Trigger a frame.
        await tester.pumpAndSettle();

        // Finds the favorite BottomNavigationBarItem.
        final Finder favorite = find.byIcon(Icons.favorite);
        // Emulate a tap on the favorite menu
        await tester.tap(favorite);
        // Trigger a frame.
        await tester.pumpAndSettle();

        // Finds the user BottomNavigationBarItem.
        final Finder user = find.byIcon(Icons.person);
        // Emulate a tap on the user menu
        await tester.tap(user);
        // Trigger a frame.
        await tester.pumpAndSettle();
      },
    );
  });
}
