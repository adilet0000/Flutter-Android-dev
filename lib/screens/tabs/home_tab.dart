import "package:android_dev/screens/content/post_widget.dart";
import "package:android_dev/screens/home_screen/models/comment_model.dart";
import "package:android_dev/screens/home_screen/models/post_model.dart";
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
    postServices.batchAddPosts(List.generate(
      10,
      (index) => PostModel(
        // picsum.photos returns a random photo; seed keeps it stable per post
        imageUrl: 'https://picsum.photos/seed/post$index/600/600',
        description: 'This is a sample post description. It can be quite long and will wrap to the next line if necessary.',
        likeCount: 0,
        comments: [
          CommentModel(userName: 'aigerim', text: 'Классное фото! 🔥', likeCount: 12),
          CommentModel(userName: 'nurlan_dev', text: 'Где это снято?', likeCount: 3),
          CommentModel(userName: 'dana.k', text: 'Очень красиво 😍', likeCount: 7),
          CommentModel(userName: 'timur', text: 'Хочу туда же', likeCount: 0),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Instagram'),
      ),
      body: ListView.builder(
        itemCount: postServices.posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: PostWidget(post: postServices.posts[index]),
          );
        },
      ),
    );
  }
}
