class PostModel {
  final String? imageUrl;
  int? likeCount;
  int? commentCount;
  final String? description;

  PostModel({
    this.imageUrl,
    this.likeCount,
    this.commentCount,
    this.description,
  });

  void addLike(int newCount) {
    // This method should ideally update the like count in a state management solution
    likeCount = newCount;
  }

  void addComment(int newCount) {
    // This method should ideally update the comment count in a state management solution
    commentCount = newCount;
  }

}