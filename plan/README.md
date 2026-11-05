# Flutter Course Plan — Fall 2026

A Flutter version of the **Android Dev Fall 2026** syllabus
([Google Sheet](https://docs.google.com/spreadsheets/d/1vjoJGLsCL3pGvZ6jle3z-8EvQkveG4KlyrfJUlnwQDU/edit?gid=0#gid=0)).
Every Kotlin / Jetpack topic is swapped for the Flutter tool that does the same job,
and this repository (the Instagram-style app in `lib/`) is the **running project**: it grows a little each week.

## Files in this folder

| File | What it is |
|---|---|
| [kotlin-to-flutter-map.md](kotlin-to-flutter-map.md) | Concept-by-concept translation table plus the package list |
| [running-project.md](running-project.md) | How the repo app evolves week by week (milestones and target folder layout) |
| [labs.md](labs.md) | Flutter versions of every practice and lab app from the syllabus |
| [final-project.md](final-project.md) | Final project requirements, sprint plan, demo rubric |
| [weeks/](weeks/) | One lesson plan per week: goals, lecture outline, code, in-class practice, repo milestone, homework |

## Schedule (syllabus → Flutter)

| Date | Class | Syllabus topic (Kotlin) | Flutter topic | Practice / Lab | Week plan |
|---|---|---|---|---|---|
| 15.09 | 1 | Kotlin Fundamentals | Dart fundamentals (null safety, classes, records, patterns) | — | [week-01](weeks/week-01.md) |
| 17.09 | 2 | Android Studio | Flutter SDK, Android Studio/VS Code, project anatomy, hot reload, DevTools | "Select" app | [week-01](weeks/week-01.md) |
| 22.09* | 3 | Intro to state | `StatefulWidget` and `setState` | — | [week-02](weeks/week-02.md) |
| 24.09* | 4 | Convenient UI + Testing | Layout widgets plus widget tests | Art Space app | [week-02](weeks/week-02.md) |
| 29.09 | 5 | Generics, objects, extensions | Dart generics, `factory`/singletons, extension methods, sealed classes, enums | — | [week-03](weeks/week-03.md) |
| 02.10 | 6 | Collections, HOFs, LazyColumn | `List`/`Map`/`Set`, `map`/`where`/`fold`, `ListView.builder`, `GridView` | Contact Book / Courses app | [week-03](weeks/week-03.md) |
| 06.10 | 7 | Material Theming + Icons | `ThemeData`, `ColorScheme.fromSeed`, Material 3, fonts, launcher icons | — | [week-04](weeks/week-04.md) |
| 08.10 | 8 | Animations + Accessibility | Implicit/explicit animations, `Hero`, `Semantics`, text scaling | Superheroes app | [week-04](weeks/week-04.md) |
| 13.10 | 9 | Activity Lifecycle | Widget lifecycle (`initState`/`dispose`) and `AppLifecycleListener` | — | [week-05](weeks/week-05.md) |
| 15.10 / 20.10 | — | CANCELLED | — | — | — |
| 22.10 | 10 | ViewModel | **Riverpod** `Notifier` / `NotifierProvider` | Dessert Clicker | [week-06](weeks/week-06.md) |
| 27.10 | 11 | Navigation + Testing | **go_router** plus navigation tests | — | [week-07](weeks/week-07.md) |
| 29.10 | 12 | MIDTERM (written) | Midterm (written) | — | [week-07](weeks/week-07.md) |
| 03.11 | 15 | Coroutines (playground) | Dart async: `Future`, `async/await`, `Stream`, isolates (DartPad) | My City (PROJECT) | [week-08](weeks/week-08.md) |
| 05.11 | 16 | Coroutines (Android Studio) | Async in the app: `AsyncNotifier`, `AsyncValue`, `FutureProvider`, `StreamProvider` | My City (PROJECT) | [week-08](weeks/week-08.md) |
| 10.11 | 17 | Retrofit | **dio + retrofit (Dart)** with `json_serializable`/`freezed` | — | [week-09](weeks/week-09.md) |
| 12.11 | 18 | Manual DI with Repository | Repository pattern plus constructor injection | — | [week-09](weeks/week-09.md) |
| 17.11 | 19 | Hilt | **Riverpod as DI** (providers + overrides); `get_it` as the alternative | — | [week-10](weeks/week-10.md) |
| 19.11 | 20 | Images from the internet | `Image.network`, `cached_network_image` | Amphibians app | [week-10](weeks/week-10.md) |
| 24.11 | 21 | Room (persist) | **drift** (typed SQLite, closest to Room); **sqflite** raw SQL; **Hive CE** key-value store | — | [week-11](weeks/week-11.md) |
| 26.11 | 22 | Room (read and update) | drift reactive queries (`watch()`), `StreamProvider`, migrations | Bus Schedule app | [week-11](weeks/week-11.md) |
| 01.12 | 23 | WorkManager | **workmanager** plugin plus `flutter_local_notifications` | — | [week-12](weeks/week-12.md) |
| 03.12 | 24 | Advanced WorkManager | Periodic/unique/chained tasks, constraints, input data, cancellation | Water Me! app | [week-12](weeks/week-12.md) |
| 08.12 | 25 | Final Exam | Final exam | — | [week-13](weeks/week-13.md) |
| 10.12 | 26 | Final Project Sprint | Sprint 1 | — | [week-13](weeks/week-13.md) |
| 15.12 | 27 | Final Project Sprint | Sprint 2 | — | [week-14](weeks/week-14.md) |
| 17.12 | 28 | FINAL PROJECT DEMO | Demo day | — | [week-14](weeks/week-14.md) |

\* The sheet lists 24.09 before 22.09, and the class numbers jump from 12 to 15. Both look like typos in the syllabus; the table keeps the original order.

## Where we are (as of 04.11.2026)

Classes 1–12 and the midterm are done. **Next class: 05.11 — Async in the app (class 16).**
The repo currently sits at about the end of Week 4: tabbed shell, feed list, custom animations, one widget test.
It has **no state management, no data layer, and no persistence yet**. That is intentional: Weeks 6–12 add those layers to this code.
If Riverpod and go_router were not covered in classes 10–11, run the [catch-up session](running-project.md#catch-up-weeks-67-in-one-session) at the start of class 16.

## Core stack chosen for the course

| Need | Choice | Why |
|---|---|---|
| State management (ViewModel) | `flutter_riverpod` | Compile-safe, testable, doubles as the DI container (one tool for Weeks 6, 9 and 10) |
| Navigation | `go_router` | Official, declarative, deep-link ready, maps directly onto Navigation Compose routes |
| Networking (Retrofit) | `dio` + `retrofit` + `json_serializable` | Same annotation style as Retrofit, so students recognise it |
| Local DB (Room) | `drift` | Tables, DAOs, typed queries, reactive `Stream`s, and migrations, the same ideas as Room |
| Lightweight storage | `hive_ce` / `shared_preferences` | Settings, flags, and caches that don't need SQL |
| Background work (WorkManager) | `workmanager` | Wraps Android WorkManager itself |
| Images | `cached_network_image` | Coil equivalent: disk cache, placeholders |

Install packages with `flutter pub add <name>` so you always get the current compatible version; the plan does not pin versions.
