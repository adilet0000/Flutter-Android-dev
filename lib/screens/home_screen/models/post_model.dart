import 'package:android_dev/screens/home_screen/models/comment_model.dart';

/// Immutable: to change a post, create a copy with copyWith().
/// Riverpod notices a new object and rebuilds the UI.
class PostModel {
  final int id;
  final String imageUrl;
  final String description;
  final int likeCount;
  final bool isLiked;
  final List<CommentModel> comments;

  const PostModel({
    required this.id,
    required this.imageUrl,
    this.description = '',
    this.likeCount = 0,
    this.isLiked = false,
    this.comments = const [],
  });

  int get commentCount => comments.length;

  PostModel copyWith({
    int? likeCount,
    bool? isLiked,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id,
      imageUrl: imageUrl,
      description: description,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      comments: comments ?? this.comments,
    );
  }
}
