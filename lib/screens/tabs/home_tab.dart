import "package:android_dev/screens/content/post_widget.dart";
import "package:android_dev/screens/content/story_widget.dart";
import "package:android_dev/screens/home_screen/providers/post_providers.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

/// No initState / setState / PostServices() here anymore:
/// the data lives in Riverpod and is loaded by the providers themselves.
class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);
    final stories = ref.watch(storiesProvider);

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
                    story: story,
                    onTap: () => ref
                        .read(storiesProvider.notifier)
                        .markViewed(story.userName),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Feed takes the rest of the screen
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PostWidget(post: posts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
