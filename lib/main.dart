import 'package:flutter/material.dart';
import 'package:logique_test/core/app/application.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const Application());
}
