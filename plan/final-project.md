# Final Project

Students either **finish the Instaclone** (this repo) or propose their own app that has the same technical scope (proposal due by the Week 11 lab).

## Required technical checklist

| Area | Requirement | Course week |
|---|---|---|
| UI | At least 4 screens, Material 3 theme with light and dark mode, consistent spacing | 2–4 |
| Lists | At least one `ListView.builder` / `GridView.builder` with real data | 3 |
| Animation & a11y | At least one meaningful animation; all icons and images have semantic labels | 4 |
| State | Riverpod for all shared state; no business logic inside widgets | 6 |
| Navigation | go_router with at least one parameterised route and a shell (tabs) | 7 |
| Async | Loading, error, and data states handled through `AsyncValue` | 8 |
| Network | At least one REST API through dio/retrofit with JSON models | 9 |
| Architecture | Repository layer; dependencies supplied through providers (no `new Repo()` in widgets) | 9–10 |
| Images | Network images with caching and placeholders | 10 |
| Persistence | drift DB (offline cache or user data) **and** one Hive CE or shared_preferences use | 11 |
| Background | At least one workmanager task (sync, reminder, or upload) | 12 |
| Tests | At least 5 unit tests (notifiers/repositories) and 3 widget tests; `flutter test` passes | 2, 6, 7 |
| Quality | `flutter analyze` reports 0 issues; README with screenshots and setup steps | — |

## Instaclone feature ideas (pick at least 3 beyond the milestones)
- Create post: pick an image (`image_picker`), add a caption, save it to drift, upload via a background task.
- Profile screen: header plus a 3-column grid of the user's posts.
- Saved posts (bookmark) stored in drift, with a "Saved" tab.
- Comments screen with an optimistic update.
- Stories row: horizontal `ListView` with a `Hero` transition to a full-screen story and a progress bar animation.
- Search with debounce (`Timer`) against the API.
- Daily "you have new posts" notification from a periodic task.

## Sprint plan

| Date | Session | Goal |
|---|---|---|
| 10.12 | Sprint 1 | Feature freeze on scope; all required checklist items at least stubbed; instructor check-in (10 min per student/team) |
| 15.12 | Sprint 2 | Bug fixing, tests, `flutter analyze` clean, polish, README; dry-run demo |
| 17.12 | Demo day | 7-minute demo + 3 minutes of Q&A |

## Demo rubric (100 pts)

| Criterion | Points |
|---|---|
| Works live on a device or emulator, no crashes | 20 |
| Architecture (layers, providers, repository, no logic in widgets) | 20 |
| Data: network + local DB + background work all demonstrated | 20 |
| UI/UX quality, theming, animation, accessibility | 15 |
| Tests and code quality (`flutter test`, `flutter analyze`) | 15 |
| Explanation: can answer "why did you choose X" questions | 10 |
