import "package:android_dev/screens/content/post_widget.dart";
import "package:android_dev/screens/content/story_widget.dart";
import "package:android_dev/screens/home_screen/providers/post_providers.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

/// Feed screen. Data comes from the database through StreamProviders,
/// so it is an AsyncValue: loading → data (or error).
class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(feedProvider);
    final stories = ref.watch(storiesProvider).value ?? const [];
    final viewed = ref.watch(viewedStoriesProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Instagram'),
      ),
      body: Column(
        children: [
          // Stories bar right under the AppBar
          Container(
            height: 110,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: StoryWidget(
                    story: story.copyWith(
                        isViewed: viewed.contains(story.userName)),
                    onTap: () => ref
                        .read(viewedStoriesProvider.notifier)
                        .markViewed(story.userName),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Feed takes the rest of the screen
          Expanded(
            child: posts.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text('Не удалось загрузить ленту: $error')),
              data: (posts) => ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: PostWidget(post: posts[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
