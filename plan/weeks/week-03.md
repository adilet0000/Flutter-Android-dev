# Week 3 — Generics, Objects, Extensions, Collections, Lists

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 5 | 29.09 | Generics, objects, and extensions | Dart generics, singletons/`factory`, extensions, sealed classes, enums |
| 6 | 02.10 | Collections, higher-order functions, LazyColumn | Collections + `map`/`where`/`fold` + `ListView.builder`/`GridView` |

## Class 5 — Generics, objects, extensions
1. Generic classes and functions: `class Result<T>`, `T firstOr<T>(List<T> l, T fallback)`.
2. Bounded generics: `T extends Comparable<T>`.
3. Kotlin `object` → Dart singleton:
   ```dart
   class Analytics {
     Analytics._();
     static final instance = Analytics._();
   }
   ```
   `factory` constructors.
4. `data class` → manual `==`/`hashCode`/`copyWith`; preview `freezed` (used from Week 9).
5. Enhanced enums: `enum PostType { photo('📷'), reel('🎬'); const PostType(this.icon); final String icon; }`
6. Sealed classes + exhaustive `switch`:
   ```dart
   sealed class FeedState {}
   class Loading extends FeedState {}
   class Loaded extends FeedState { Loaded(this.posts); final List<Post> posts; }
   class Failed extends FeedState { Failed(this.message); final String message; }

   Widget view(FeedState s) => switch (s) {
     Loading() => const CircularProgressIndicator(),
     Loaded(:final posts) => Text('${posts.length} posts'),
     Failed(:final message) => Text(message),
   };
   ```
7. Extensions: `extension on DateTime { String get timeAgo => ... }` (used for post timestamps).

## Class 6 — Collections, higher-order functions, lists
1. `List`, `Set`, `Map` literals; spread `...`; collection-`if`/`for` inside widget lists.
2. `map`, `where`, `any`, `every`, `fold`, `reduce`, `expand`, `take`, `skip`, `sort`; laziness of `Iterable` (`.toList()`).
3. Function types and tear-offs: `posts.map(PostWidget.new)`.
4. `ListView` vs `ListView.builder` (equivalent to `Column` vs `LazyColumn`); `separatorBuilder`; `GridView.builder` with `SliverGridDelegateWithFixedCrossAxisCount`.
5. Keys in lists: `ValueKey(post.id)`.

**Practice:** Contact Book. **Lab:** Courses app (see [labs.md](../labs.md)).

## Repo milestone
- `lib/features/feed/domain/post.dart`: a `Post` model (id, username, avatarUrl, imageUrl, caption, likes, createdAt) with `copyWith`.
- `fake_posts.dart`: 10 distinct posts generated with `List.generate` (use `https://picsum.photos/id/$i/600/600` for images).
- `HomeTab` renders `posts.map(...)` through `ListView.builder` with `itemCount: posts.length`.
- Replace the Search `PlaceholderTab` with a 3-column `GridView.builder` of thumbnails.
- A `timeAgo` extension shows "2h" under each post.
