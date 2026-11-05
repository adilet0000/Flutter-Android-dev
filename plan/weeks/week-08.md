# Week 8 — Coroutines → Dart Async

| Class | Date | Syllabus (Kotlin) | Flutter version | Project |
|---|---|---|---|---|
| 15 | 03.11 | Coroutines (playground) | Dart async in DartPad | My City (PROJECT) |
| 16 | 05.11 | Coroutines (Android Studio) | Async in the app with Riverpod | My City (PROJECT) |

## Class 15 — Async playground (DartPad)
| Kotlin coroutines | Dart |
|---|---|
| `suspend fun getWeather(): String` | `Future<String> getWeather() async` |
| `delay(1000)` | `await Future.delayed(const Duration(seconds: 1))` |
| `runBlocking { }` | `main() async { }` |
| `launch { }` (fire and forget) | Call a `Future` without `await` (`unawaited(...)`) |
| `async { }.await()` in parallel | `final (a, b) = await (f1(), f2()).wait;` or `Future.wait` |
| `try/catch` in a coroutine | `try/catch` around `await`; `Future.catchError` |
| `withTimeout` | `.timeout(Duration(...))` |
| `Flow` / `collect` | `Stream` / `await for`, `listen` |
| `Dispatchers.Default` for CPU work | `await Isolate.run(() => heavy())` |
| Job cancellation | No built-in `Future` cancellation: cancel `StreamSubscription`s, use a flag, or rely on `ref.onDispose` |

Teach the **event loop** (microtasks vs events) with a "predict the print order" exercise:
```dart
void main() async {
  print('1');
  Future(() => print('4'));
  scheduleMicrotask(() => print('3'));
  print('2');
  await Future.delayed(Duration.zero);
  print('5');
}
```
Streams: `Stream.periodic`, `async*` / `yield`, `StreamController`, `map`/`where` on streams.

## Class 16 — Async in the app
1. `FutureBuilder` / `StreamBuilder` (plain Flutter); explain why rebuilding a widget can restart its future.
2. Riverpod: `FutureProvider`, `StreamProvider`, `AsyncNotifier`.
3. `AsyncValue.when(data:, loading:, error:)`, which replaces the Kotlin `UiState` sealed class.
4. Refresh: `ref.invalidate(provider)`, `RefreshIndicator`.
5. Cancellation and cleanup: `autoDispose` providers, `ref.onDispose`.

```dart
class FeedController extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() => ref.watch(postsRepositoryProvider).fetchFeed();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(postsRepositoryProvider).fetchFeed());
  }
}

final feedControllerProvider =
    AsyncNotifierProvider<FeedController, List<Post>>(FeedController.new);

// UI
ref.watch(feedControllerProvider).when(
  data: (posts) => RefreshIndicator(
      onRefresh: ref.read(feedControllerProvider.notifier).refresh,
      child: ListView.builder(...)),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (e, _) => ErrorView(message: '$e', onRetry: () => ref.invalidate(feedControllerProvider)),
);
```

## Repo milestone
- `FakePostsRepository.fetchFeed()` returns `Future.delayed(1s, () => fakePosts)` and fails randomly 20% of the time.
- The feed shows loading, error with retry, and data states; pull-to-refresh works.
- `toggleLike` becomes an **optimistic update**: update `state` first, then `await` the repository and roll back on error.

## My City project
Due at the end of Week 8; spec in [labs.md](../labs.md#prj--my-city-weeks-78-graded-project).
