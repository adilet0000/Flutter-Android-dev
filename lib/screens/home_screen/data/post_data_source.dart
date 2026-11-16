import 'package:android_dev/screens/home_screen/data/posts_data.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';

/// "Where the data comes from" — only the contract, no implementation.
/// PostServices depends on this abstraction, not on a concrete class,
/// so the source can be swapped (mock file, server API, test fake)
/// without touching the service or the UI.
abstract class PostDataSource {
  List<PostModel> loadPosts();
  List<StoryModel> loadStories();
}

/// Current implementation: hardcoded data from posts_data.dart.
/// Later this can be replaced by e.g. ApiPostDataSource that calls a server.
class MockPostDataSource implements PostDataSource {
  @override
  List<PostModel> loadPosts() => postsData;

  @override
  List<StoryModel> loadStories() => storiesData;
}
