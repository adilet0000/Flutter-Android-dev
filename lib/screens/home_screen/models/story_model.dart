/// Immutable: to change a story, create a copy with copyWith().
class StoryModel {
  final String userName; // unique, like an Instagram username
  final String avatarUrl;
  final bool isViewed;

  const StoryModel({
    required this.userName,
    required this.avatarUrl,
    this.isViewed = false,
  });

  StoryModel copyWith({bool? isViewed}) {
    return StoryModel(
      userName: userName,
      avatarUrl: avatarUrl,
      isViewed: isViewed ?? this.isViewed,
    );
  }
}
