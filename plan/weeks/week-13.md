# Week 13 — Final Exam & Sprint 1

| Class | Date | Syllabus | Flutter version |
|---|---|---|---|
| 25 | 08.12 | Final Exam | Final exam |
| 26 | 10.12 | Final Project Sprint | Sprint 1 |

## Class 25 — Final exam (covers mainly classes 15–24)
Suggested format: written (60%) + a practical task on a laptop (40%), 120 min total.

**Written**
- Event loop: predict the print order (Future vs microtask vs `await`).
- `AsyncValue` states and how to render each one.
- Given a Retrofit interface in Kotlin, write the Dart `retrofit` equivalent.
- Draw the provider dependency graph for a given feature; show how to override it in a test.
- drift: write a table, a `watch` query, and a migration step.
- Explain why a `workmanager` task cannot use `ref.read`.

**Practical (starter repo provided)**
Add a "Liked posts" screen that:
1. reads from the drift DB through a `StreamProvider`,
2. is reachable through a go_router route,
3. has one widget test using a provider override.

## Class 26 — Sprint 1
See [final-project.md](../final-project.md#sprint-plan). Each student or team shows: their scope list, the checklist status, and one blocker. The instructor does 10-minute code reviews focused on architecture (logic in widgets? providers built inside `build`?).
