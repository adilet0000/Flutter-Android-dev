import "package:android_dev/screens/home_screen/models/comment_model.dart";
import "package:flutter/material.dart";

/// One comment row: avatar, name + text, and a like button on the right.
class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;

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
