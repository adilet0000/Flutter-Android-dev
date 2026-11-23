/// One comment, combined from comments + users (author) + comment_likes.
class CommentModel {
  final int id;
  final int postId;
  final String userName; // author
  final String text;
  final int likeCount;
  final bool isLiked; // liked by the CURRENT user

  const CommentModel({
    required this.id,
    required this.postId,
    required this.userName,
    required this.text,
    this.likeCount = 0,
    this.isLiked = false,
  });
}
