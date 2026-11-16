import 'package:android_dev/screens/home_screen/data/post_data_source.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';
import 'package:android_dev/screens/home_screen/services/post_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Dependency Injection ────────────────────────────────────────────
// Riverpod creates the objects and passes them to whoever needs them.
// Chain: postDataSourceProvider → postServicesProvider → notifiers → UI.
// In tests any link can be replaced with overrideWithValue(...).

/// Where the data comes from. Swap MockPostDataSource for a real API here,
/// and nothing else in the app needs to change.
final postDataSourceProvider = Provider<PostDataSource>(
  (ref) => MockPostDataSource(),
);

/// The service gets its data source injected through the constructor.
final postServicesProvider = Provider<PostServices>(
  (ref) => PostServices(ref.watch(postDataSourceProvider)),
);

// ─── State (data manager) ────────────────────────────────────────────

/// Holds the list of posts. UI reads it with ref.watch(postsProvider)
/// and changes it with ref.read(postsProvider.notifier).toggleLike(...).
class PostsNotifier extends Notifier<List<PostModel>> {
  PostServices get _service => ref.read(postServicesProvider);

  /// Initial state: called once, the first time someone reads the provider.
  @override
  List<PostModel> build() => ref.watch(postServicesProvider).getPosts();

  void toggleLike(int postId) {
    _updatePost(postId, _service.toggleLike);
  }

  void toggleCommentLike(int postId, int commentIndex) {
    _updatePost(postId, (post) => _service.toggleCommentLike(post, commentIndex));
  }

  /// Replaces one post in the list with its changed copy.
  /// Assigning `state` notifies every widget that watches this provider.
  void _updatePost(int postId, PostModel Function(PostModel) change) {
    state = [
      for (final post in state)
        if (post.id == postId) change(post) else post,
    ];
  }
}

final postsProvider = NotifierProvider<PostsNotifier, List<PostModel>>(
  PostsNotifier.new,
);

/// One post by id. Used by the comments sheet so it updates live
/// when a comment is liked.
final postByIdProvider = Provider.family<PostModel, int>((ref, postId) {
  return ref.watch(postsProvider).firstWhere((post) => post.id == postId);
});

/// Holds the list of stories.
class StoriesNotifier extends Notifier<List<StoryModel>> {
  PostServices get _service => ref.read(postServicesProvider);

  @override
  List<StoryModel> build() => ref.watch(postServicesProvider).getStories();

  void markViewed(String userName) {
    state = [
      for (final story in state)
        if (story.userName == userName) _service.markViewed(story) else story,
    ];
  }
}

final storiesProvider = NotifierProvider<StoriesNotifier, List<StoryModel>>(
  StoriesNotifier.new,
);
