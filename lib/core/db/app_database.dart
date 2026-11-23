import 'dart:math';

import 'package:android_dev/core/auth/password_hasher.dart';
import 'package:android_dev/core/db/seed_data.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ─── Tables ──────────────────────────────────────────────────────────
// Each class = one SQLite table, each getter = one column.
// drift generates the SQL and Dart classes in app_database.g.dart
// (run: dart run build_runner build).
//
//   users ──< posts ──< comments
//     │         │          │
//     └──< post_likes >────┘ (user ↔ post)
//     └──< comment_likes >─  (user ↔ comment)
//     └──< sessions           (who is logged in)

@DataClassName('UserRow')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 30).unique()();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  TextColumn get avatarUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PostRow')
class Posts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get authorId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get imageUrl => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// One row = "user X liked post Y". The pair is the primary key,
/// so the same user physically cannot like the same post twice.
/// Like count = COUNT(*) of rows for the post — no number to get out of sync.
@DataClassName('PostLikeRow')
class PostLikes extends Table {
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get postId =>
      integer().references(Posts, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {userId, postId};
}

@DataClassName('CommentRow')
class Comments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get postId =>
      integer().references(Posts, #id, onDelete: KeyAction.cascade)();
  IntColumn get authorId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get body => text().withLength(min: 1, max: 500)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('CommentLikeRow')
class CommentLikes extends Table {
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get commentId =>
      integer().references(Comments, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {userId, commentId};
}

/// The logged-in user. Always at most one row (id = 1).
/// Kept in the DB so the user stays logged in after restarting the app.
@DataClassName('SessionRow')
class Sessions extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get loggedInAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

// ─── Database ────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [Users, Posts, PostLikes, Comments, CommentLikes, Sessions],
)
class AppDatabase extends _$AppDatabase {
  /// [executor] is optional so tests can pass an in-memory database.
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'instaclone'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Runs only once — when the database file is created.
        onCreate: (m) async {
          await m.createAll();
          await _seed();
        },
        // Runs on every open. SQLite ignores foreign keys unless enabled.
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Fills an empty database with the demo users, posts, comments and likes.
  Future<void> _seed() async {
    final userIds = <String, int>{};
    for (final user in seedUsers) {
      final salt = PasswordHasher.newSalt();
      userIds[user.userName] = await into(users).insert(
        UsersCompanion.insert(
          username: user.userName,
          passwordHash: PasswordHasher.hash(demoPassword, salt),
          salt: salt,
          avatarUrl: Value(user.avatarUrl),
        ),
      );
    }
    final allUserIds = userIds.values.toList();

    for (var i = 0; i < seedPosts.length; i++) {
      final post = seedPosts[i];
      final postId = await into(posts).insert(
        PostsCompanion.insert(
          authorId: allUserIds[i % allUserIds.length], // spread posts across users
          imageUrl: post.imageUrl,
          description: Value(post.description),
        ),
      );

      // There are only 10 demo users, so a post can have at most 10 real likes.
      final likers = allUserIds.take(post.likeCount % (allUserIds.length + 1));
      for (final userId in likers) {
        await into(postLikes).insert(
          PostLikesCompanion.insert(userId: userId, postId: postId),
        );
      }

      for (final comment in post.comments) {
        final commentId = await into(comments).insert(
          CommentsCompanion.insert(
            postId: postId,
            authorId: userIds[comment.userName]!,
            body: comment.text,
          ),
        );
        final commentLikers =
            allUserIds.take(min(comment.likeCount, allUserIds.length));
        for (final userId in commentLikers) {
          await into(commentLikes).insert(
            CommentLikesCompanion.insert(userId: userId, commentId: commentId),
          );
        }
      }
    }
  }
}
