import 'package:android_dev/screens/home_screen/data/post_data_source.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';

/// Business logic for the feed: loading data and the rules for likes/views.
///
/// It does NOT store state anymore — Riverpod (see post_providers.dart)
/// keeps the current lists and calls these methods to change them.
/// Every method takes an object and returns a NEW changed object.
class PostServices {
  // Dependency Injection: the data source is passed in from outside
  // (by postServicesProvider) instead of being created here with `new`.
  final PostDataSource dataSource;

  PostServices(this.dataSource);

  List<PostModel> getPosts() => dataSource.loadPosts();

  List<StoryModel> getStories() => dataSource.loadStories();

  PostModel toggleLike(PostModel post) {
    return post.copyWith(
      isLiked: !post.isLiked,
      likeCount: post.likeCount + (post.isLiked ? -1 : 1),
    );
  }

  PostModel toggleCommentLike(PostModel post, int commentIndex) {
    final comments = [...post.comments]; // copy the list
    final comment = comments[commentIndex];
    comments[commentIndex] = comment.copyWith(
      isLiked: !comment.isLiked,
      likeCount: comment.likeCount + (comment.isLiked ? -1 : 1),
    );
    return post.copyWith(comments: comments);
  }

  StoryModel markViewed(StoryModel story) => story.copyWith(isViewed: true);
}
