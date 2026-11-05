import "package:android_dev/screens/home_screen/models/comment_model.dart";
import "package:flutter/material.dart";

/// Instagram-style comments panel that slides up from the bottom.
class CommentsSheet extends StatefulWidget {
  final List<CommentModel> comments;
  const CommentsSheet({super.key, required this.comments});

  @override
  State<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<CommentsSheet> {
  @override
  Widget build(BuildContext context) {
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
              child: widget.comments.isEmpty
                  ? const Center(child: Text('Пока нет комментариев'))
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index) =>
                          _buildComment(widget.comments[index]),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComment(CommentModel comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            child: Text(comment.userName[0].toUpperCase()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(comment.text, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(comment.toggleLike),
            child: Column(
              children: [
                Icon(
                  comment.isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 16,
                  color: comment.isLiked ? Colors.red : Colors.grey,
                ),
                Text(
                  '${comment.likeCount}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
