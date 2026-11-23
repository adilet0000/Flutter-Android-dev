/// One post in the feed, already combined from several DB tables:
/// posts + users (author) + post_likes (count, isLiked) + comments (count).
/// The UI never writes to it — changes go to the database, and the
/// database stream delivers a fresh PostModel.
class PostModel {
  final int id;
  final String authorName;
  final String? authorAvatarUrl;
  final String imageUrl;
  final String description;
  final int likeCount;
  final bool isLiked; // liked by the CURRENT user
  final int commentCount;

  const PostModel({
    required this.id,
    required this.authorName,
    this.authorAvatarUrl,
    required this.imageUrl,
    this.description = '',
    this.likeCount = 0,
    this.isLiked = false,
    this.commentCount = 0,
  });
}
