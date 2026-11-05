# Practice & Lab Apps (Flutter versions)

Each lab keeps the **same app idea** as the Android codelab in the syllabus, but uses the Flutter stack for that week.
Labs are separate small projects (`flutter create lab_<name>`), while the running project lives in this repo.

| # | App | Week | Flutter skills checked |
|---|---|---|---|
| P1 | "Select" app | 1 | Project setup, `Text`, `Column`, `ElevatedButton`, hot reload |
| L1 | Art Space | 2 | `StatefulWidget`, `setState`, `Image.asset`, layout, widget test |
| P2 | Contact Book | 3 | Model class, `List`, `where`/`map`, `ListView.builder`, search filter |
| L2 | Courses | 3 | `GridView.builder`, data class, extension methods |
| L3 | Superheroes | 4 | `ThemeData`, light/dark, `google_fonts`, `AnimatedSize` expand card, `Semantics` |
| L4 | Dessert Clicker | 6 | Riverpod `Notifier`, state survives rotation, unit tests on the notifier |
| PRJ | My City | 7–8 | go_router multi-screen, adaptive layout (`LayoutBuilder` list/detail), Riverpod |
| L5 | Amphibians | 10 | dio/retrofit, `json_serializable`, `AsyncNotifier`, `CachedNetworkImage`, provider overrides in tests |
| L6 | Bus Schedule | 11 | drift tables + DAO, `watch()` streams, `StreamProvider`, two screens |
| L7 | Water Me! | 12 | workmanager one-off delayed tasks, `flutter_local_notifications`, input data |

---

## P1 — "Select" app (Week 1)
A one-screen app with a list of options (e.g. three flavours). Tapping one shows "You selected X".
- Required: `Scaffold`, `AppBar`, `Column`, `RadioListTile` or `ChoiceChip`, a `Text` result.
- Stretch: change the seed colour and hot-reload it.

## L1 — Art Space (Week 2)
A gallery of 3–5 artworks with Previous/Next buttons.
- `StatefulWidget` holding `int _index`; `Image.asset` (declare assets in `pubspec.yaml`).
- Wrap around at the ends.
- **Test:** tapping Next changes the title text (`find.text`, `tester.tap`, `tester.pump`).

## P2 — Contact Book (Week 3)
- `class Contact { final String name; final String phone; }`, 20 fake contacts.
- `ListView.builder`; a `TextField` filter using `where`; sort with `sort((a, b) => a.name.compareTo(b.name))`.
- Stretch: group by first letter with `groupBy` from `package:collection`, shown with sticky headers.

## L2 — Courses (Week 3)
- `GridView.builder` with 2 columns, each card showing an image, title, and course count.
- Extension: `extension on int { String get coursesLabel => '$this courses'; }`

## L3 — Superheroes (Week 4)
- `ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(...))` with light and dark themes; custom `TextTheme` via `google_fonts`.
- Cards expand on tap (`AnimatedSize`); a staggered list entrance animation.
- Every image has a `semanticLabel`; check with TalkBack and with large font scaling.

## L4 — Dessert Clicker (Week 6)
- Port the provided starter (one big `StatefulWidget`) to `DessertController extends Notifier<DessertState>`.
- `DessertState` is immutable (`copyWith`), holding revenue, desserts sold, and current dessert.
- Rotate the device: the state must survive. Explain why `setState` state would also survive (Flutter does not recreate the widget tree on rotation), and when it would not (the process is killed).
- **Tests:** unit-test the notifier with `ProviderContainer`.

## PRJ — My City (Weeks 7–8, graded project)
- Categories → recommendations list → detail screen, all as go_router routes.
- Adaptive layout: `LayoutBuilder` shows list and detail side by side when wider than 600 dp.
- Week 8 addition: load data through a fake async repository (`Future.delayed`) with loading and error states via `AsyncValue`.
- Rubric: navigation 25%, state 25%, adaptive UI 20%, code structure 20%, tests 10%.

## L5 — Amphibians (Week 10)
- API: `https://android-kotlin-fun-mars-server.appspot.com/amphibians` (the codelab endpoint; if it is down, use any JSON list of name/type/description/img_src).
- `AmphibiansApi` (retrofit) → `AmphibiansRepository` → `amphibiansProvider` (`FutureProvider` or `AsyncNotifier`).
- `CachedNetworkImage` with placeholder and error widgets.
- **Test:** override the repository provider with a fake and assert that the list renders.

## L6 — Bus Schedule (Week 11)
- Ship a pre-populated SQLite DB asset (or seed on first run in `MigrationStrategy.onCreate`).
- drift table `Schedules(id, stopName, arrivalTimeInMillis)`.
- `watchAll()` and `watchByStop(name)` streams → `StreamProvider.family`.
- Two screens: full schedule → tap a stop → the stop's schedule.

## L7 — Water Me! (Week 12)
- A plant list; "Remind me" lets the user pick 5 seconds / 1 day / 7 days / 30 days.
- `Workmanager().registerOneOffTask(uniqueName, 'waterReminder', initialDelay: ..., inputData: {'plant': name})`.
- `callbackDispatcher` shows a notification with `flutter_local_notifications`.
- Android 13+: request the `POST_NOTIFICATIONS` permission.
