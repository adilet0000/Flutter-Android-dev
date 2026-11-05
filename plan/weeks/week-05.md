# Week 5 — Lifecycle

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 9 | 13.10 | Activity Lifecycle | Widget lifecycle + app lifecycle |
| — | 15.10 | CANCELLED | — |

## Goals
- Know the `State` lifecycle methods and when each runs.
- React to the app going to the background and coming back.
- Understand why Flutter does not lose state on rotation, and when state *is* lost.

## Lecture outline
1. Android: one `FlutterActivity` (`android/app/src/main/kotlin/.../MainActivity.kt`) hosts the whole Flutter app.
2. `State` lifecycle: `createState` → `initState` → `didChangeDependencies` → `build` → `didUpdateWidget` → `deactivate` → `dispose`.
   - Point at `AnimatedIndexedStack.didUpdateWidget` in the repo.
3. App lifecycle: `AppLifecycleListener(onResume:, onPause:, onInactive:, onHide:, onDetached:)`, or the older `WidgetsBindingObserver`.
4. Configuration changes: rotation triggers a rebuild with a new `MediaQuery`, but the `State` objects survive. Process death loses everything (preview of persistence in Week 11).
5. Resource cleanup: controllers, `StreamSubscription`, `Timer` → `dispose`.
6. Debugging: put `debugPrint` in each method, rotate the device, switch tabs, background the app.

**Live demo:**
```dart
class _HomeTabState extends State<HomeTab> {
  late final AppLifecycleListener _listener;
  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: () => debugPrint('feed: resume → refresh'),
      onPause: () => debugPrint('feed: pause'),
    );
  }
  @override
  void dispose() { _listener.dispose(); super.dispose(); }
}
```

## Repo milestone
Add lifecycle logging to `HomeTab` and `PostWidget`. Answer in the README: "Why is `PostWidget` for tab 2 not built until you open it?" (because of the `_visited` set in `AnimatedIndexedStack`).

## Homework
A lifecycle quiz (10 questions) to prepare for the midterm.
