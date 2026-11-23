import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Passwords are NEVER stored as plain text.
/// We store: a random "salt" + sha256(salt + password).
/// On login we hash the typed password with the same salt and compare.
///
/// Note: sha256 is fine for a learning project. A real app would hash
/// passwords on a server with a slow algorithm like bcrypt or argon2.
class PasswordHasher {
  static String newSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  static String hash(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }

  static bool verify(String password, String salt, String expectedHash) {
    return hash(password, salt) == expectedHash;
  }
}
