# Week 9 — Networking & Repository Pattern

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 17 | 10.11 | Retrofit | dio + retrofit (Dart) + json_serializable / freezed |
| 18 | 12.11 | Manual DI with Repository | Repository pattern + constructor injection |

## Class 17 — Retrofit → dio + retrofit
1. HTTP basics, REST, JSON; Android `INTERNET` permission (already present in debug builds; add it to `android/app/src/main/AndroidManifest.xml` for release).
2. Start with `package:http` for one call so students see the raw `jsonDecode`.
3. Then the Retrofit-style approach:
   ```bash
   flutter pub add dio retrofit json_annotation freezed_annotation
   flutter pub add --dev build_runner retrofit_generator json_serializable freezed
   ```
   ```dart
   @freezed
   abstract class PicsumPhoto with _$PicsumPhoto {
     const factory PicsumPhoto({
       required String id,
       required String author,
       @JsonKey(name: 'download_url') required String downloadUrl,
     }) = _PicsumPhoto;
     factory PicsumPhoto.fromJson(Map<String, dynamic> json) => _$PicsumPhotoFromJson(json);
   }

   @RestApi(baseUrl: 'https://picsum.photos/v2')
   abstract class PicsumApi {
     factory PicsumApi(Dio dio) = _PicsumApi;

     @GET('/list')
     Future<List<PicsumPhoto>> getPhotos(@Query('page') int page, @Query('limit') int limit);
   }
   ```
   Run `dart run build_runner watch -d`.
4. dio interceptors: logging (`LogInterceptor`), timeouts, error mapping (`DioException` → a domain `NetworkFailure`).

## Class 18 — Repository + manual DI
1. Why use a repository: a single source of truth that hides where the data comes from (network, DB, fake).
2. Abstract interface + implementations:
   ```dart
   abstract interface class PostsRepository {
     Future<List<Post>> fetchFeed({int page = 1});
     Future<void> setLiked(String postId, bool liked);
   }
   class NetworkPostsRepository implements PostsRepository {
     NetworkPostsRepository(this._api);   // constructor injection
     final PicsumApi _api;
     ...  // map PicsumPhoto → Post (DTO → domain)
   }
   ```
3. Manual DI: an `AppContainer` class that builds `Dio` → `PicsumApi` → `NetworkPostsRepository` once in `main()` and passes it down (mirrors the codelab's `AppContainer`).
4. Testing: `FakePostsRepository` in tests; no network in unit tests.

## Repo milestone
- `lib/core/network/dio_client.dart`, `lib/features/feed/data/{picsum_api.dart, posts_repository.dart}`.
- The feed loads real images from Picsum; captions come from `https://dummyjson.com/posts` (or are generated locally).
- Infinite scroll: load page N+1 when the user nears the end of the list.
- Unit test: `FeedController` with `FakePostsRepository`.
