import 'package:android_dev/screens/home_screen/models/comment_model.dart';

class PostModel {
  final String? imageUrl;
  int? likeCount;
  int? commentCount;
  final String? description;
  bool isLiked;
  final List<CommentModel> comments;

  PostModel({
    this.imageUrl,
    this.likeCount,
    this.commentCount,
    this.description,
    this.isLiked = false,
    List<CommentModel>? comments,
  }) : comments = comments ?? [];

  void addLike(int newCount) {
    // This method should ideally update the like count in a state management solution
    likeCount = newCount;
  }

  void toggleLike() {
    isLiked = !isLiked;
    addLike((likeCount ?? 0) + (isLiked ? 1 : -1));
  }

  void addComment(int newCount) {
    // This method should ideally update the comment count in a state management solution
    commentCount = newCount;
  }

}
