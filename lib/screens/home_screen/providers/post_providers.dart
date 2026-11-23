import 'package:android_dev/core/auth/auth_providers.dart';
import 'package:android_dev/core/db/database_provider.dart';
import 'package:android_dev/screens/home_screen/models/comment_model.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';
import 'package:android_dev/screens/home_screen/models/user_model.dart';
import 'package:android_dev/screens/home_screen/services/post_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Dependency Injection ────────────────────────────────────────────
// databaseProvider → postServicesProvider → feed providers → UI

final postServicesProvider = Provider<PostServices>(
  (ref) => PostServices(ref.watch(databaseProvider)),
);

// ─── Data (read) ─────────────────────────────────────────────────────
// StreamProvider listens to a database stream: when a like or comment is
// written, the DB emits a new list and every watching widget rebuilds.
// They also watch currentUserProvider, so after login/logout they restart
// with the new user's "isLiked" values.

final feedProvider = StreamProvider<List<PostModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(postServicesProvider).watchFeed(user.id);
});

/// Posts liked by the current user (Activity tab). Derived from the feed:
/// the feed already knows `isLiked` for this user, so we just filter it.
/// Because the feed is a DB stream, un-liking a post removes it here too.
final likedPostsProvider = Provider<AsyncValue<List<PostModel>>>((ref) {
  return ref
      .watch(feedProvider)
      .whenData((posts) => posts.where((p) => p.isLiked).toList());
});

/// Comments of one post: ref.watch(commentsProvider(postId)).
final commentsProvider =
    StreamProvider.family<List<CommentModel>, int>((ref, postId) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(postServicesProvider).watchComments(postId, user.id);
});

final storiesProvider = StreamProvider<List<StoryModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(postServicesProvider).watchStories(user.id);
});

/// Which stories were opened in this session (kept in memory, not in the DB).
/// Resets automatically when another user logs in.
class ViewedStoriesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    ref.watch(currentUserProvider);
    return {};
  }

  void markViewed(String userName) => state = {...state, userName};
}

final viewedStoriesProvider =
    NotifierProvider<ViewedStoriesNotifier, Set<String>>(
  ViewedStoriesNotifier.new,
);

// ─── Actions (write) ─────────────────────────────────────────────────

/// Actions of the current user. Widgets call these instead of talking
/// to the service directly, so they don't need to know the user id.
class FeedController {
  FeedController(this._service, this._user);

  final PostServices _service;
  final UserModel? _user;

  Future<void> toggleLike(int postId) async {
    final user = _user;
    if (user == null) return;
    await _service.toggleLike(userId: user.id, postId: postId);
  }

  Future<void> toggleCommentLike(int commentId) async {
    final user = _user;
    if (user == null) return;
    await _service.toggleCommentLike(userId: user.id, commentId: commentId);
  }

  Future<void> addPost(String imageUrl, String description) async {
    final user = _user;
    if (user == null) return;
    await _service.addPost(
      userId: user.id,
      imageUrl: imageUrl,
      description: description,
    );
  }

  Future<void> addComment(int postId, String text) async {
    final user = _user;
    if (user == null) return;
    await _service.addComment(userId: user.id, postId: postId, text: text);
  }
}

final feedControllerProvider = Provider<FeedController>(
  (ref) => FeedController(
    ref.watch(postServicesProvider),
    ref.watch(currentUserProvider),
  ),
);
