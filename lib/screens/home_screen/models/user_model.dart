/// The logged-in user as the UI sees it. Never contains the password.
class UserModel {
  final int id;
  final String username;
  final String? avatarUrl;

  const UserModel({required this.id, required this.username, this.avatarUrl});
}
