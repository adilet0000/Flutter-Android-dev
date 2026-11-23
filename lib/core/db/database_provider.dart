import 'package:android_dev/core/db/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dependency Injection: the single database instance for the whole app.
/// Services receive it through their constructors.
/// Tests replace it with an in-memory database via overrideWithValue.
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
