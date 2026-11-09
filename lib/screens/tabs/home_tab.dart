import "package:android_dev/screens/content/post_widget.dart";
import "package:android_dev/screens/content/story_widget.dart";
import "package:android_dev/screens/home_screen/data/posts_data.dart";
import "package:android_dev/screens/home_screen/services/post_services.dart";
import "package:flutter/material.dart";

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Created once, so likes/comments are not reset on every rebuild.
  final PostServices postServices = PostServices();

  @override
  void initState() {
    super.initState();
    // Data comes from posts_data.dart, added via the service's batch functions
    postServices.batchAddPosts(postsData);
    postServices.batchAddStories(storiesData);
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: postServices.stories.length,
              itemBuilder: (context, index) {
                final story = postServices.stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: StoryWidget(
                    story: story,
                    onTap: () => setState(() => story.isViewed = true),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Feed takes the rest of the screen
          Expanded(
            child: ListView.builder(
              itemCount: postServices.posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PostWidget(post: postServices.posts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
