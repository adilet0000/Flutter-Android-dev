import 'package:android_dev/core/auth/auth_service.dart';
import 'package:android_dev/core/db/database_provider.dart';
import 'package:android_dev/screens/home_screen/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI: AuthService gets the database from databaseProvider.
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.watch(databaseProvider)),
);

/// Who is logged in: null = nobody (show the login screen).
/// AsyncNotifier because reading the session from the DB takes time.
class AuthNotifier extends AsyncNotifier<UserModel?> {
  AuthService get _auth => ref.read(authServiceProvider);

  @override
  Future<UserModel?> build() => ref.watch(authServiceProvider).restoreSession();

  /// Throws AuthException on wrong data — the login screen shows the message.
  Future<void> login(String username, String password) async {
    state = AsyncData(await _auth.login(username, password));
  }

  Future<void> register(String username, String password) async {
    state = AsyncData(await _auth.register(username, password));
  }

  Future<void> logout() async {
    await _auth.logout();
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(
  AuthNotifier.new,
);

/// Shortcut: the current user or null.
final currentUserProvider = Provider<UserModel?>(
  (ref) => ref.watch(authProvider).value,
);
