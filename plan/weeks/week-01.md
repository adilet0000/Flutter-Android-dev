# Week 1 — Dart Fundamentals & Flutter Tooling

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 1 | 15.09 | Kotlin Fundamentals | Dart fundamentals |
| 2 | 17.09 | Android Studio | Flutter SDK, IDE, project anatomy, hot reload |

## Goals
- Write and run Dart programs in DartPad.
- Install Flutter, get `flutter doctor` passing, and run this repo on an emulator.
- Explain what each file in a Flutter project does.

## Class 1 — Dart fundamentals (DartPad: dartpad.dev)
1. `main()`, `print`, string interpolation `'$name ${a + b}'`.
2. `var` / `final` / `const`; types; type inference.
3. Null safety: `String?`, `?.`, `??`, `!`, `late`. Compare with Kotlin's `?:` and `!!`.
4. Functions: positional, optional `[]`, named `{required}` parameters, arrow `=>` syntax.
5. Control flow: `if`, `for`, `for-in`, `while`, `switch` expressions.
6. Classes: constructors, `this.` initialisers, named constructors, getters. Show both constructor styles:
   ```dart
   class Post {
     const Post({required this.author, required this.caption});
     final String author;
     final String caption;
   }
   ```
   The repo also uses the newer `const new({super.key})` form (see `lib/screens/tabs/home_tab.dart`). It means the same thing.
7. Records and patterns: `(String, int) pair = ('likes', 42); final (label, count) = pair;`

**Exercises:** FizzBuzz; a `BankAccount` class that rejects withdrawals that would make the balance negative; a function that takes a `String?` and returns its length or 0.

## Class 2 — Flutter tooling
1. Install the Flutter SDK, Android Studio (with the Flutter and Dart plugins) or VS Code; run `flutter doctor`.
2. Clone this repo → `flutter pub get` → `flutter run`.
3. Tour the project: `pubspec.yaml` (equivalent to `build.gradle`), `lib/`, `android/`, `test/`, `analysis_options.yaml`.
4. Everything is a widget: `MaterialApp` → `Scaffold` → `AppBar` / `body`.
5. Hot reload vs hot restart; Flutter DevTools (widget inspector).
6. `flutter analyze`, `flutter test`.

**Practice:** "Select" app (see [labs.md](../labs.md#p1--select-app-week-1)).

## Repo milestone
Run the app. Each student writes a short paragraph in their notebook for every file in `lib/` describing what it does.

## Homework
- Dart exercises 1–3 above, submitted as a DartPad link.
- Change the AppBar title of `HomeTab` and the scaffold background colour, then hot reload.
