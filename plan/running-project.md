# Running Project — "Instaclone" (this repo)

The app in `lib/` is an Instagram-style client. Students do not start a new app for each topic; each week adds one layer to this one,
so by the final project they have a full, layered app that uses state, navigation, networking, DI, a database, and background work.

## What exists today (commit `35996aa`)

| File | Contains | Syllabus topics already shown |
|---|---|---|
| `lib/main.dart` | `MaterialApp` → `MainScreen` | Class 2 |
| `lib/screens/main_screen.dart` | `StatefulWidget`, `setState` tab index, `AnimatedBottomNavigationBar` | Class 3 (state), Class 7 (icons) |
| `lib/screens/tabs/home_tab.dart` | `ListView.builder` feed of 10 posts | Class 6 (LazyColumn) |
| `lib/screens/content/post_widget.dart` | Card layout, `Image.network`, action row; `isLiked` hard-coded with a TODO comment | Class 4 (layout), Class 20 preview |
| `lib/screens/tabs/placeholder_tab.dart` | Reusable placeholder screen | Class 4 |
| `lib/widgets/animated_indexed_stack.dart` | Custom tab transition that keeps each page's state alive, plus lazy page building | Class 8 (animations), Class 9 (`didUpdateWidget`) |
| `test/tab_switch_test.dart` | Widget test for the stack | Class 4 / 11 (testing) |

Known gaps that later weeks fix:
- `PostWidget.isLiked` is a constant, so the like button does nothing (fixed in Week 6, persisted in Week 11).
- The feed contains 10 copies of a single hard-coded post (Week 3 model, Week 9 network).
- No theme: colours are hard-coded (`Colors.grey[200]`, `Colors.black`) (Week 4).
- No routes: post detail and profile screens don't exist (Week 7).
- The repo uses the newer `const new({super.key})` constructor syntax. Teach it alongside the classic `const PostWidget({super.key})` form so students can read both.

## Target folder layout (end of semester)

```
lib/
  main.dart                 # ProviderScope + MaterialApp.router
  app/
    router.dart             # go_router config (Week 7)
    theme.dart              # light/dark ThemeData (Week 4)
  core/
    network/dio_client.dart # Week 9
    db/app_database.dart    # drift (Week 11)
    background/workers.dart # workmanager (Week 12)
  features/
    feed/
      data/                 # PostsApi, PostsDao, PostsRepository
      domain/post.dart      # freezed model
      presentation/         # FeedScreen, PostWidget, feed_controller.dart
    profile/ ...
    new_post/ ...
    activity/ ...
  widgets/animated_indexed_stack.dart
test/
  unit/ widget/ (+ integration_test/)
```

## Milestones (one per week)

| Week | Milestone in the repo | Done when |
|---|---|---|
| 1 | Run the app, explore the structure, `flutter doctor` passes | App runs on an emulator and the student can explain every file |
| 2 | Make the like button work with local `setState` (convert `PostWidget` to stateful) | Heart toggles red; widget test covers it |
| 3 | `Post` model class + `List<Post>` fake data; feed renders different posts; Search tab grid (`GridView`) | 10 distinct posts; search grid shows thumbnails |
| 4 | `app/theme.dart` with light and dark themes; remove hard-coded colours; double-tap-to-like heart animation; `Semantics` labels on action buttons | Dark mode works; TalkBack reads "Like post" |
| 5 | Log lifecycle events; pause the video placeholder or refresh on resume using `AppLifecycleListener` | Console shows resume/pause; no leaked controllers |
| 6 | Add Riverpod. `FeedController extends Notifier<List<Post>>`; likes live in the controller, not the widget | `setState` removed from `PostWidget`; unit test for `toggleLike` |
| 7 | Replace the manual tab switch with `go_router` `StatefulShellRoute.indexedStack`; add `/post/:id` and `/profile/:username` routes | Back button works; deep link `/post/3` opens the detail screen |
| 8 | Fake async repo with `Future.delayed`; `FeedController` becomes an `AsyncNotifier`; loading spinner, error + retry, pull-to-refresh | All three UI states visible |
| 9 | Real API via dio + retrofit (e.g. `https://picsum.photos/v2/list` for images, `https://dummyjson.com/posts` for captions); `PostsRepository` interface + implementation | Feed loads from the network; repository is unit-tested with a fake |
| 10 | Providers become the DI graph (`dioProvider` → `postsApiProvider` → `postsRepositoryProvider`); `CachedNetworkImage` with placeholder/error | Tests override `postsRepositoryProvider`; images cache offline |
| 11 | drift DB: `Posts` and `Likes` tables; offline-first repository (DB as source of truth, network refresh); Hive CE box for drafts/settings | Likes survive an app restart; feed shows cached posts in airplane mode |
| 12 | workmanager: periodic "sync feed" task + a one-off "upload post" task with a notification | Task runs in the background (check with `adb shell dumpsys jobscheduler`) |
| 13–14 | Final project features (see [final-project.md](final-project.md)) | Demo |

## Catch-up: Weeks 6–7 in one session

The repo has no Riverpod or go_router yet. If those classes ran in Kotlin, or the code was not written, spend the first 45 minutes of class 16 on:
1. `flutter pub add flutter_riverpod go_router`
2. Wrap `MainApp` in `ProviderScope`.
3. Move `isLiked` into a `FeedController` `Notifier` (see [week-06](weeks/week-06.md)).
4. Swap `MainScreen`'s `setState` index for `StatefulShellRoute.indexedStack`. Keep `AnimatedIndexedStack` as the shell's `navigatorContainerBuilder`, so students see their own animation reused.
