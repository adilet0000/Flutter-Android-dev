# Week 10 — Automatic DI & Network Images

| Class | Date | Syllabus (Kotlin) | Flutter version |
|---|---|---|---|
| 19 | 17.11 | Automatic DI with Hilt | Riverpod providers as the DI graph (alt: get_it + injectable) |
| 20 | 19.11 | Images from the internet | `Image.network`, `cached_network_image` |

## Class 19 — Hilt → Riverpod DI
| Hilt | Riverpod |
|---|---|
| `@HiltAndroidApp` | `ProviderScope` at the root |
| `@Module @Provides fun provideDio()` | `final dioProvider = Provider((ref) => Dio(...));` |
| `@Inject constructor(api: Api)` | `Provider((ref) => Repo(ref.watch(apiProvider)))` |
| `@Singleton` | Default (non-autoDispose) provider = one per `ProviderScope` |
| `@ViewModelScoped` / scoped lifetimes | `autoDispose`, `family` |
| `@Binds` interface → impl | Provider typed as the interface: `Provider<PostsRepository>` |
| Test modules / `@TestInstallIn` | `ProviderScope(overrides: [postsRepositoryProvider.overrideWithValue(FakePostsRepository())])` |

```dart
final dioProvider = Provider<Dio>((ref) => buildDio());
final picsumApiProvider = Provider((ref) => PicsumApi(ref.watch(dioProvider)));
final postsRepositoryProvider =
    Provider<PostsRepository>((ref) => NetworkPostsRepository(ref.watch(picsumApiProvider)));
```
Delete the Week 9 `AppContainer`; compare the before and after.

Show for 15 minutes: **get_it + injectable**, which is the closest in style to Hilt (annotations + codegen), so students recognise it in other codebases. Explain why the course uses Riverpod: one tool for both state and DI, and overrides make testing easy.

Optional: `riverpod_generator` (`@riverpod` annotations) as the "annotation" flavour.

## Class 20 — Images from the internet
1. `Image.network` with `loadingBuilder` / `errorBuilder` (the repo already uses `Image.network` in `post_widget.dart`).
2. `CachedNetworkImage(imageUrl:, placeholder:, errorWidget:)`: disk cache, equivalent to Coil.
3. Sizing: `fit: BoxFit.cover`, `AspectRatio(aspectRatio: 1)`, `memCacheWidth` to save memory.
4. Precaching the next images: `precacheImage`.
5. Circular avatars: `CircleAvatar(backgroundImage: CachedNetworkImageProvider(url))`.

**Lab:** Amphibians (see [labs.md](../labs.md#l5--amphibians-week-10)).

## Repo milestone
- All dependencies are providers; nothing in `lib/features/**/presentation` constructs a repository or `Dio`.
- `PostWidget` uses `CachedNetworkImage` with a shimmer placeholder and a broken-image error widget.
- Widget test: override `postsRepositoryProvider` with a fake and assert that 3 posts render.
