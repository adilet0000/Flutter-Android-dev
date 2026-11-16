import "package:android_dev/screens/home_screen/data/post_data_source.dart";
import "package:android_dev/screens/home_screen/models/comment_model.dart";
import "package:android_dev/screens/home_screen/models/post_model.dart";
import "package:android_dev/screens/home_screen/models/story_model.dart";
import "package:android_dev/screens/home_screen/providers/post_providers.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";

/// Fake data source for tests: small, predictable data instead of 20 posts.
class FakePostDataSource implements PostDataSource {
  @override
  List<PostModel> loadPosts() => const [
        PostModel(
          id: 1,
          imageUrl: "test.jpg",
          likeCount: 10,
          comments: [CommentModel(userName: "tester", text: "hi", likeCount: 2)],
        ),
        PostModel(id: 2, imageUrl: "test2.jpg", likeCount: 0),
      ];

  @override
  List<StoryModel> loadStories() => const [
        StoryModel(userName: "tester", avatarUrl: "avatar.jpg"),
      ];
}

void main() {
  late ProviderContainer container;

  setUp(() {
    // Dependency Injection in action: replace the real data source with
    // the fake one. The service, notifiers and UI code stay untouched.
    container = ProviderContainer.test(
      overrides: [
        postDataSourceProvider.overrideWithValue(FakePostDataSource()),
      ],
    );
  });

  test("posts are loaded from the injected data source", () {
    expect(container.read(postsProvider).length, 2);
    expect(container.read(storiesProvider).length, 1);
  });

  test("toggleLike likes and unlikes only the chosen post", () {
    final notifier = container.read(postsProvider.notifier);

    notifier.toggleLike(1);
    var post = container.read(postByIdProvider(1));
    expect(post.isLiked, true);
    expect(post.likeCount, 11);
    expect(container.read(postByIdProvider(2)).likeCount, 0);

    notifier.toggleLike(1);
    post = container.read(postByIdProvider(1));
    expect(post.isLiked, false);
    expect(post.likeCount, 10);
  });

  test("toggleCommentLike changes the comment inside the post", () {
    container.read(postsProvider.notifier).toggleCommentLike(1, 0);

    final comment = container.read(postByIdProvider(1)).comments[0];
    expect(comment.isLiked, true);
    expect(comment.likeCount, 3);
  });

  test("markViewed marks the story as viewed", () {
    container.read(storiesProvider.notifier).markViewed("tester");
    expect(container.read(storiesProvider).first.isViewed, true);
  });
}
