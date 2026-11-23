import "package:android_dev/core/auth/auth_providers.dart";
import "package:android_dev/core/auth/auth_service.dart";
import "package:android_dev/core/db/app_database.dart";
import "package:android_dev/core/db/database_provider.dart";
import "package:android_dev/screens/home_screen/providers/post_providers.dart";
import "package:drift/drift.dart" show driftRuntimeOptions;
import "package:drift/native.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  // Each test creates its own fresh in-memory DB; silence drift's warning.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late ProviderContainer container;
  late AppDatabase db;

  setUp(() {
    // Dependency Injection in action: the real on-disk database is replaced
    // by an empty in-memory one. Services, providers and UI code stay
    // untouched — they just receive a different AppDatabase.
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer.test(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() => db.close());

  AuthNotifier auth() => container.read(authProvider.notifier);

  test("new database is seeded with 10 users and 20 posts", () async {
    expect(await db.select(db.users).get(), hasLength(10));
    expect(await db.select(db.posts).get(), hasLength(20));
  });

  test("nobody is logged in at first", () async {
    expect(await container.read(authProvider.future), isNull);
  });

  test("register logs the user in; duplicate username is rejected", () async {
    await container.read(authProvider.future);
    await auth().register("New_User", "secret1");

    final user = container.read(currentUserProvider);
    expect(user?.username, "new_user"); // stored in lower case

    await expectLater(
      auth().register("new_user", "another1"),
      throwsA(isA<AuthException>()),
    );
  });

  test("password is not stored as plain text", () async {
    await container.read(authProvider.future);
    await auth().register("hashcheck", "secret1");

    final row = await (db.select(db.users)
          ..where((u) => u.username.equals("hashcheck")))
        .getSingle();
    expect(row.passwordHash, isNot(contains("secret1")));
  });

  test("login: wrong password fails, right password works", () async {
    await container.read(authProvider.future);

    await expectLater(
      auth().login("aigerim", "wrong-pass"),
      throwsA(isA<AuthException>()),
    );
    expect(container.read(currentUserProvider), isNull);

    await auth().login("aigerim", "password123");
    expect(container.read(currentUserProvider)?.username, "aigerim");
  });

  test("logout clears the session in the database", () async {
    await container.read(authProvider.future);
    await auth().login("aigerim", "password123");
    await auth().logout();

    expect(container.read(currentUserProvider), isNull);
    expect(await db.select(db.sessions).get(), isEmpty);
  });

  test("session survives an app restart", () async {
    await container.read(authProvider.future);
    await auth().login("aigerim", "password123");

    // "Restart": a new AuthService reads the session from the same DB
    final restored =
        await AuthService(container.read(databaseProvider)).restoreSession();
    expect(restored?.username, "aigerim");
  });

  test("likes are per user and stored in the database", () async {
    final service = container.read(postServicesProvider);
    final users = await db.select(db.users).get();
    final a = users[0].id, b = users[1].id;

    // Find a post that nobody liked yet to keep the numbers simple
    final feed = await service.watchFeed(a).first;
    final post = feed.firstWhere((p) => p.likeCount == 0);

    await service.toggleLike(userId: a, postId: post.id);

    final forA = (await service.watchFeed(a).first)
        .firstWhere((p) => p.id == post.id);
    final forB = (await service.watchFeed(b).first)
        .firstWhere((p) => p.id == post.id);
    expect(forA.isLiked, true);
    expect(forA.likeCount, 1);
    expect(forB.isLiked, false); // B sees A's like in the count only
    expect(forB.likeCount, 1);

    await service.toggleLike(userId: a, postId: post.id); // unlike
    final after = (await service.watchFeed(a).first)
        .firstWhere((p) => p.id == post.id);
    expect(after.isLiked, false);
    expect(after.likeCount, 0);
  });

  test("added comment is saved with its author and can be liked", () async {
    await container.read(authProvider.future);
    await auth().register("commenter", "secret1");
    final me = container.read(currentUserProvider)!;
    final service = container.read(postServicesProvider);

    await container.read(feedControllerProvider).addComment(1, "Привет!");

    final comments = await service.watchComments(1, me.id).first;
    final mine = comments.last;
    expect(mine.text, "Привет!");
    expect(mine.userName, "commenter");

    await container.read(feedControllerProvider).toggleCommentLike(mine.id);
    final liked = (await service.watchComments(1, me.id).first).last;
    expect(liked.isLiked, true);
    expect(liked.likeCount, 1);
  });

  test("new post is saved with its author and shown first in the feed",
      () async {
    await container.read(authProvider.future);
    await auth().register("poster", "secret1");
    final me = container.read(currentUserProvider)!;

    await container
        .read(feedControllerProvider)
        .addPost("https://picsum.photos/600", "Мой первый пост");

    final feed = await container.read(postServicesProvider).watchFeed(me.id).first;
    expect(feed, hasLength(21));
    expect(feed.first.authorName, "poster");
    expect(feed.first.description, "Мой первый пост");
    expect(feed.first.likeCount, 0);
  });

  test("liked posts list shows only this account's likes", () async {
    await container.read(authProvider.future);
    await auth().register("liker", "secret1");
    final sub = container.listen(likedPostsProvider, (_, _) {});

    await container.read(feedProvider.future);
    expect(sub.read().value, isEmpty); // new account liked nothing yet

    await container.read(feedControllerProvider).toggleLike(3);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(sub.read().value!.map((p) => p.id), [3]);

    await container.read(feedControllerProvider).toggleLike(3); // unlike
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(sub.read().value, isEmpty);
  });
}
