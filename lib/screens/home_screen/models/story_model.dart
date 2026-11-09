class StoryModel {
  final String userName;
  final String avatarUrl;
  bool isViewed;

  StoryModel({
    required this.userName,
    required this.avatarUrl,
    this.isViewed = false,
  });
}
