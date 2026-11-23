import 'package:android_dev/core/auth/auth_providers.dart';
import 'package:android_dev/screens/auth/auth_screen.dart';
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
      home: AuthGate(),
    );
  }
}

/// Decides what to show: login screen or the app.
/// Reacts automatically to login/register/logout via authProvider.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return auth.when(
      // Reading the saved session from the database
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Ошибка базы данных: $error')),
      ),
      data: (user) => user == null ? const AuthScreen() : const MainScreen(),
    );
  }
}
