# Week 7 — Navigation + Testing, Midterm

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 11 | 27.10 | Navigation + Testing | go_router + navigation tests |
| 12 | 29.10 | MIDTERM EXAM (Written) | Midterm (written) |

## Class 11 — Navigation
1. Navigator 1.0 basics (`Navigator.push(MaterialPageRoute(...))`), which is what most tutorials show.
2. go_router: `GoRouter(routes: [...])`, `MaterialApp.router(routerConfig: router)`.
3. Path and query parameters: `/post/:id`, `state.pathParameters['id']`.
4. `context.go` (replace the location) vs `context.push` (stack on top); `context.pop(result)`.
5. Tabs with separate back stacks: `StatefulShellRoute.indexedStack` (equivalent to bottom nav with saved state in Navigation Compose).
6. Redirects (auth guard preview).
7. Testing navigation: pump `MaterialApp.router` with a test router, tap, `pumpAndSettle`, `expect(find.byType(PostDetailScreen), findsOneWidget)`.

```dart
final router = GoRouter(
  initialLocation: '/feed',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScreen(shell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/feed', builder: (_, _) => const HomeTab(), routes: [
            GoRoute(path: 'post/:id',
                builder: (_, s) => PostDetailScreen(id: s.pathParameters['id']!)),
          ]),
        ]),
        StatefulShellBranch(routes: [GoRoute(path: '/search', builder: (_, _) => const SearchTab())]),
        // new post, activity, profile ...
      ],
    ),
  ],
);
```
In `MainScreen`: `activeIndex: shell.currentIndex`, `onTap: shell.goBranch`.

## Repo milestone
- `lib/app/router.dart`; `MainScreen` now takes a `StatefulNavigationShell` instead of using `setState`.
- Tapping a post image opens `/feed/post/:id` with a `Hero` image transition.
- Tapping a username opens `/profile/:username`.
- Test: tap a post and expect the detail screen; press back and expect the feed.

## Class 12 — Midterm (written), classes 1–11
Suggested format (90 min):
- 15 multiple-choice questions: Dart null safety, widget types, lifecycle order, `ref.watch` vs `ref.read`, `go` vs `push`.
- 3 code-reading questions: predict the output or the rebuild count (e.g. `AnimatedIndexedStack`, a `setState` trap, an `Iterable` laziness trap).
- 2 code-writing questions: (a) a `Notifier` with two actions; (b) a `ListView.builder` screen with layout given as a sketch.
- 1 short essay: compare `setState` and Riverpod for a feature of the student's choosing.
