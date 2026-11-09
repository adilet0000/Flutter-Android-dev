import "package:android_dev/screens/content/comments_sheet.dart";
import "package:android_dev/screens/home_screen/models/post_model.dart";
import "package:flutter/material.dart";

class PostWidget extends StatefulWidget {
  final PostModel? post;
  const PostWidget({super.key,required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  // Like state lives in PostModel so it survives ListView scrolling.
  bool get isLiked => widget.post?.isLiked ?? false;

 void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return CommentsSheet(comments: widget.post?.comments ?? []);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                widget.post?.imageUrl ?? 'https://picsum.photos/600',
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    widget.post?.toggleLike();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  openBottomSheet();
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Нравится: ${widget.post?.likeCount ?? 0}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post?.description ?? '',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          if ((widget.post?.comments ?? []).isNotEmpty)
            GestureDetector(
              onTap: openBottomSheet,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Посмотреть все комментарии (${widget.post!.comments.length})',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),

        ],)

    );
  }
}
