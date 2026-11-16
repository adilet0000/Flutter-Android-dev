import "package:android_dev/screens/content/comment_widget.dart";
import "package:android_dev/screens/home_screen/providers/post_providers.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

/// Instagram-style comments panel that slides up from the bottom.
/// Gets only the post id and reads the post itself from Riverpod,
/// so liking a comment updates this sheet immediately.
class CommentsSheet extends ConsumerWidget {
  final int postId;
  const CommentsSheet({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch = "read AND rebuild me when it changes"
    final comments = ref.watch(postByIdProvider(postId)).comments;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Комментарии',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: comments.isEmpty
                  ? const Center(child: Text('Пока нет комментариев'))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: comments.length,
                      itemBuilder: (context, index) => CommentWidget(
                        comment: comments[index],
                        onLikeTap: () => ref
                            .read(postsProvider.notifier)
                            .toggleCommentLike(postId, index),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
