import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "screens/main_screen.dart";

void main() {
  // ProviderScope is the "storage" for all Riverpod providers.
  // It must wrap the whole app, otherwise ref.watch/ref.read won't work.
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen()
    );
  }
}
