/// Immutable: to change a comment, create a copy with copyWith().
/// Riverpod notices a new object and rebuilds the UI.
class CommentModel {
  final String userName;
  final String text;
  final int likeCount;
  final bool isLiked;

  const CommentModel({
    required this.userName,
    required this.text,
    this.likeCount = 0,
    this.isLiked = false,
  });

  CommentModel copyWith({int? likeCount, bool? isLiked}) {
    return CommentModel(
      userName: userName,
      text: text,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
