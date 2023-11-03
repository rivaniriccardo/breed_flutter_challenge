import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breeds/view/breeds_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initApp();
  runApp(const MyApp());
}

Future _initApp() async {
  await configureDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breeds Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BreedsPage(),
    );
  }
}
