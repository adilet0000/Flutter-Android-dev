# Week 11 — Room → drift / sqflite / Hive CE

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 21 | 24.11 | Room (persist) | drift: tables, database, inserts; compare with sqflite and Hive CE |
| 22 | 26.11 | Room (read and update) | drift queries, `watch()` streams, updates, migrations, offline-first |

## Class 21 — Persisting data
1. Storage options overview (see the table in [kotlin-to-flutter-map.md](../kotlin-to-flutter-map.md#local-storage--which-one-when)).
2. **sqflite in 15 minutes** (raw SQL, like `SQLiteOpenHelper`), to show what drift saves you from:
   ```dart
   final db = await openDatabase('app.db', version: 1,
       onCreate: (db, v) => db.execute('CREATE TABLE likes(post_id TEXT PRIMARY KEY)'));
   await db.insert('likes', {'post_id': id});
   ```
3. **drift** (the main tool):
   ```bash
   flutter pub add drift drift_flutter path_provider
   flutter pub add --dev drift_dev build_runner
   ```
   ```dart
   class CachedPosts extends Table {          // @Entity
     TextColumn get id => text()();
     TextColumn get username => text()();
     TextColumn get imageUrl => text()();
     TextColumn get caption => text()();
     IntColumn get likes => integer()();
     BoolColumn get isLiked => boolean().withDefault(const Constant(false))();
     @override
     Set<Column> get primaryKey => {id};
   }

   @DriftDatabase(tables: [CachedPosts])      // @Database
   class AppDatabase extends _$AppDatabase {
     AppDatabase() : super(driftDatabase(name: 'instaclone'));
     @override
     int get schemaVersion => 1;

     Future<void> upsertPosts(List<CachedPostsCompanion> rows) =>
         batch((b) => b.insertAllOnConflictUpdate(cachedPosts, rows));
   }

   final databaseProvider = Provider<AppDatabase>((ref) {
     final db = AppDatabase();
     ref.onDispose(db.close);
     return db;
   });
   ```
4. **Hive CE** for key-value / object data (`hive_ce`, `hive_ce_flutter`):
   ```dart
   await Hive.initFlutter();
   final drafts = await Hive.openBox<String>('drafts');
   drafts.put('newPostCaption', text);
   ```
   Use it for the New Post caption draft and the dark-mode setting (or `shared_preferences` for the setting).

## Class 22 — Reading & updating
1. Queries: `select(cachedPosts)..where((p) => p.isLiked.equals(true))..orderBy([...])`.
2. Reactive reads: `.watch()` returns a `Stream<List<CachedPost>>` (Room's `Flow`) → `StreamProvider`.
3. Updates: `(update(cachedPosts)..where((p) => p.id.equals(id))).write(CachedPostsCompanion(isLiked: Value(liked)))`.
4. DAOs with `@DriftAccessor` to split queries per feature.
5. Migrations: bump `schemaVersion`, `MigrationStrategy(onUpgrade: (m, from, to) async { if (from < 2) await m.addColumn(...); })`.
6. **Offline-first repository:** the UI watches the DB; `refresh()` fetches from the network and upserts into the DB; the stream emits automatically.
   ```dart
   class OfflineFirstPostsRepository implements PostsRepository {
     Stream<List<Post>> watchFeed() => _db.select(_db.cachedPosts).watch().map(toDomain);
     Future<void> refresh() async => _db.upsertPosts((await _api.getPhotos(1, 30)).map(toRow).toList());
   }
   ```
7. Inspect the DB: Android Studio **App Inspection → Database Inspector** works with drift/sqflite databases.

**Lab:** Bus Schedule (see [labs.md](../labs.md#l6--bus-schedule-week-11)).

## Repo milestone
- `lib/core/db/app_database.dart`; the feed is now a `StreamProvider` over drift.
- Likes persist across restarts; the feed renders cached posts in airplane mode.
- New Post caption draft saved in a Hive CE box.
- A "Saved" bookmark list stored in drift (a second table, schema version 2 → write a migration).
