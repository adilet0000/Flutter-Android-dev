# Week 2 — State & Layout + Testing

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 3 | 22/24.09 | Intro to state | `StatefulWidget`, `setState` |
| 4 | 22/24.09 | Convenient UI + Testing | Layout widgets + widget tests |

## Goals
- Know when to use `StatelessWidget` and when to use `StatefulWidget`.
- Build layouts from `Row`/`Column`/`Stack`/`Expanded`/`Padding`.
- Write a first widget test.

## Class 3 — Intro to state
1. Compose `remember { mutableStateOf(0) }` maps to a field in `State<T>` plus `setState(() => ...)`.
2. Walk through `lib/screens/main_screen.dart`: `_currentIndex` with `setState` in `onTap`.
3. Stateless vs stateful; why `build()` must be pure and cheap.
4. Input: `TextField` with `TextEditingController`; `Switch`, `Slider`.
5. Lifting state up: pass callbacks down (`ValueChanged<int>`).

**Live code:** a tip calculator (amount `TextField`, tip % `Slider`, round-up `Switch`).

## Class 4 — Convenient UI + Testing
1. Layout: `Row`, `Column`, `MainAxisAlignment`, `Expanded`/`Flexible`, `Spacer`, `Stack` + `Positioned`, `SizedBox`, `Padding`, `Container`/`DecoratedBox`.
2. Walk through `post_widget.dart`: identify each layout widget and its Compose equivalent.
3. Constraints: "constraints go down, sizes go up, the parent sets the position."
4. Testing: `testWidgets`, `pumpWidget`, `find.text`, `find.byIcon`, `tester.tap`, `pump`/`pumpAndSettle`, `expect`.
5. Read `test/tab_switch_test.dart` together.

**Lab:** Art Space (see [labs.md](../labs.md#l1--art-space-week-2)).

## Repo milestone
Make the like button in `PostWidget` work locally:
```dart
class PostWidget extends StatefulWidget { ... }
class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;
  // IconButton(icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border,
  //                       color: _isLiked ? Colors.red : null),
  //            onPressed: () => setState(() => _isLiked = !_isLiked))
}
```
Add `test/post_widget_test.dart` that taps the heart and expects `Icons.favorite`.

## Homework
Finish Art Space with at least 2 widget tests.
