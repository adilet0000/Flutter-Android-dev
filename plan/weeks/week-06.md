# Week 6 — ViewModel → Riverpod

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| — | 20.10 | CANCELLED | — |
| 10 | 22.10 | ViewModel | Riverpod `Notifier` / `NotifierProvider` |

## Goals
- Move state and logic out of widgets into a testable controller.
- Read state with `ref.watch`, call actions with `ref.read(...notifier)`.
- Unit-test a notifier without any UI.

## Concept bridge
| Android | Riverpod |
|---|---|
| `class FeedViewModel : ViewModel()` | `class FeedController extends Notifier<FeedState>` |
| `private val _uiState = MutableStateFlow(...)` | `state` (built into `Notifier`) |
| `val uiState: StateFlow` | `feedControllerProvider` |
| `viewModel()` in a composable | `ref.watch(feedControllerProvider)` in a `ConsumerWidget` |
| `viewModel.onLike(id)` | `ref.read(feedControllerProvider.notifier).toggleLike(id)` |
| `onCleared()` | `ref.onDispose(...)` |

## Lecture outline
1. Why: `PostWidget` has a comment, "This should ideally be managed by state management." Likes are lost when the widget is rebuilt and can't be shared with the Profile tab.
2. `flutter pub add flutter_riverpod`; wrap the app in `ProviderScope`.
3. `ConsumerWidget` / `ConsumerStatefulWidget`; `ref.watch` vs `ref.read` vs `ref.listen` (for snackbars).
4. Immutable state + `copyWith`; never mutate lists in place.
5. Selecting part of the state: `ref.watch(provider.select((s) => s.likedIds.contains(id)))`.
6. Testing with `ProviderContainer`.

```dart
class FeedController extends Notifier<List<Post>> {
  @override
  List<Post> build() => fakePosts;

  void toggleLike(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isLiked: !p.isLiked, likes: p.likes + (p.isLiked ? -1 : 1)) else p,
    ];
  }
}

final feedControllerProvider =
    NotifierProvider<FeedController, List<Post>>(FeedController.new);
```

```dart
test('toggleLike flips isLiked', () {
  final c = ProviderContainer();
  addTearDown(c.dispose);
  final id = c.read(feedControllerProvider).first.id;
  c.read(feedControllerProvider.notifier).toggleLike(id);
  expect(c.read(feedControllerProvider).first.isLiked, isTrue);
});
```

Optional 10-minute bridge: show `ChangeNotifier` + `ListenableBuilder` first, so students see the plain-Flutter version before Riverpod.

**Lab:** Dessert Clicker (see [labs.md](../labs.md#l4--dessert-clicker-week-6)).

## Repo milestone
Likes live in `FeedController`; `PostWidget` goes back to being stateless (a `ConsumerWidget`); the like count shows under the actions. The Week 2 widget test still passes once it is wrapped in `ProviderScope`.
