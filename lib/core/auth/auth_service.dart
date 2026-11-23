import 'package:android_dev/core/auth/password_hasher.dart';
import 'package:android_dev/core/db/app_database.dart';
import 'package:android_dev/screens/home_screen/models/user_model.dart';
import 'package:drift/drift.dart';

/// Error with a message that can be shown to the user as is.
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Registration, login, logout and "remember me" — all through the database.
class AuthService {
  // Dependency Injection: the database is passed in, not created here.
  AuthService(this._db);

  final AppDatabase _db;

  static final _usernamePattern = RegExp(r'^[a-z0-9._]{3,30}$');

  /// Called on app start: if a session row exists, the user is still logged in.
  Future<UserModel?> restoreSession() async {
    final session = await _db.select(_db.sessions).getSingleOrNull();
    if (session == null) return null;
    final user = await _findById(session.userId);
    return user == null ? null : _toModel(user);
  }

  Future<UserModel> register(String username, String password) async {
    final name = username.trim().toLowerCase();
    if (!_usernamePattern.hasMatch(name)) {
      throw const AuthException(
          'Имя: 3–30 символов, только латиница, цифры, точка и _');
    }
    if (password.length < 6) {
      throw const AuthException('Пароль должен быть не короче 6 символов');
    }
    if (await _findByName(name) != null) {
      throw const AuthException('Это имя пользователя уже занято');
    }

    final salt = PasswordHasher.newSalt();
    final id = await _db.into(_db.users).insert(
          UsersCompanion.insert(
            username: name,
            passwordHash: PasswordHasher.hash(password, salt),
            salt: salt,
          ),
        );
    await _startSession(id);
    return UserModel(id: id, username: name);
  }

  Future<UserModel> login(String username, String password) async {
    final user = await _findByName(username.trim().toLowerCase());
    // Same message for both cases, so nobody can guess which usernames exist.
    if (user == null ||
        !PasswordHasher.verify(password, user.salt, user.passwordHash)) {
      throw const AuthException('Неверное имя пользователя или пароль');
    }
    await _startSession(user.id);
    return _toModel(user);
  }

  Future<void> logout() => _db.delete(_db.sessions).go();

  Future<void> _startSession(int userId) {
    return _db.into(_db.sessions).insertOnConflictUpdate(
          SessionsCompanion.insert(id: const Value(1), userId: userId),
        );
  }

  Future<UserRow?> _findByName(String username) {
    return (_db.select(_db.users)..where((u) => u.username.equals(username)))
        .getSingleOrNull();
  }

  Future<UserRow?> _findById(int id) {
    return (_db.select(_db.users)..where((u) => u.id.equals(id)))
        .getSingleOrNull();
  }

  UserModel _toModel(UserRow row) =>
      UserModel(id: row.id, username: row.username, avatarUrl: row.avatarUrl);
}
