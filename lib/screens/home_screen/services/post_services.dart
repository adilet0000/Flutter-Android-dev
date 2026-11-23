import 'package:android_dev/core/db/app_database.dart';
import 'package:android_dev/screens/home_screen/models/comment_model.dart';
import 'package:android_dev/screens/home_screen/models/post_model.dart';
import 'package:android_dev/screens/home_screen/models/story_model.dart';
import 'package:drift/drift.dart';

/// All feed operations against the database: read posts/comments/stories,
/// like, unlike, comment.
///
/// "watch" methods return a Stream: drift re-runs the query and emits a new
/// list every time one of the tables in `readsFrom` changes. So after
/// toggleLike() the feed updates by itself — no manual refresh needed.
class PostServices {
  // Dependency Injection: the database is passed in, not created here.
  PostServices(this._db);

  final AppDatabase _db;

  // ─── Posts ───────────────────────────────────────────────────────

  Stream<List<PostModel>> watchFeed(int currentUserId) {
    return _db.customSelect(
      '''
      SELECT p.id, p.image_url, p.description,
             u.username   AS author_name,
             u.avatar_url AS author_avatar,
             (SELECT COUNT(*) FROM post_likes l WHERE l.post_id = p.id) AS like_count,
             EXISTS (SELECT 1 FROM post_likes l
                     WHERE l.post_id = p.id AND l.user_id = ?1)        AS is_liked,
             (SELECT COUNT(*) FROM comments c WHERE c.post_id = p.id)  AS comment_count
      FROM posts p
      JOIN users u ON u.id = p.author_id
      ORDER BY p.id DESC -- newest first, like Instagram
      ''',
      variables: [Variable.withInt(currentUserId)],
      readsFrom: {_db.posts, _db.users, _db.postLikes, _db.comments},
    ).watch().map((rows) => rows
        .map((row) => PostModel(
              id: row.read<int>('id'),
              authorName: row.read<String>('author_name'),
              authorAvatarUrl: row.readNullable<String>('author_avatar'),
              imageUrl: row.read<String>('image_url'),
              description: row.read<String>('description'),
              likeCount: row.read<int>('like_count'),
              isLiked: row.read<int>('is_liked') == 1,
              commentCount: row.read<int>('comment_count'),
            ))
        .toList());
  }

  /// Saves a new post by [userId]. Returns the new post's id.
  Future<int> addPost({
    required int userId,
    required String imageUrl,
    String description = '',
  }) {
    return _db.into(_db.posts).insert(
          PostsCompanion.insert(
            authorId: userId,
            imageUrl: imageUrl,
            description: Value(description),
          ),
        );
  }

  /// Like if not liked yet, otherwise remove the like.
  Future<void> toggleLike({required int userId, required int postId}) {
    return _db.transaction(() async {
      final removed = await (_db.delete(_db.postLikes)
            ..where((l) => l.userId.equals(userId) & l.postId.equals(postId)))
          .go();
      if (removed == 0) {
        await _db.into(_db.postLikes).insert(
              PostLikesCompanion.insert(userId: userId, postId: postId),
            );
      }
    });
  }

  // ─── Comments ────────────────────────────────────────────────────

  Stream<List<CommentModel>> watchComments(int postId, int currentUserId) {
    return _db.customSelect(
      '''
      SELECT c.id, c.post_id, c.body,
             u.username AS author_name,
             (SELECT COUNT(*) FROM comment_likes l WHERE l.comment_id = c.id) AS like_count,
             EXISTS (SELECT 1 FROM comment_likes l
                     WHERE l.comment_id = c.id AND l.user_id = ?2)          AS is_liked
      FROM comments c
      JOIN users u ON u.id = c.author_id
      WHERE c.post_id = ?1
      ORDER BY c.created_at, c.id
      ''',
      variables: [Variable.withInt(postId), Variable.withInt(currentUserId)],
      readsFrom: {_db.comments, _db.users, _db.commentLikes},
    ).watch().map((rows) => rows
        .map((row) => CommentModel(
              id: row.read<int>('id'),
              postId: row.read<int>('post_id'),
              userName: row.read<String>('author_name'),
              text: row.read<String>('body'),
              likeCount: row.read<int>('like_count'),
              isLiked: row.read<int>('is_liked') == 1,
            ))
        .toList());
  }

  Future<void> addComment({
    required int userId,
    required int postId,
    required String text,
  }) async {
    final body = text.trim();
    if (body.isEmpty) return;
    await _db.into(_db.comments).insert(
          CommentsCompanion.insert(postId: postId, authorId: userId, body: body),
        );
  }

  Future<void> toggleCommentLike({required int userId, required int commentId}) {
    return _db.transaction(() async {
      final removed = await (_db.delete(_db.commentLikes)
            ..where((l) =>
                l.userId.equals(userId) & l.commentId.equals(commentId)))
          .go();
      if (removed == 0) {
        await _db.into(_db.commentLikes).insert(
              CommentLikesCompanion.insert(userId: userId, commentId: commentId),
            );
      }
    });
  }

  // ─── Stories ─────────────────────────────────────────────────────

  /// Stories = other users who have an avatar.
  Stream<List<StoryModel>> watchStories(int currentUserId) {
    final query = _db.select(_db.users)
      ..where((u) => u.avatarUrl.isNotNull() & u.id.equals(currentUserId).not())
      ..orderBy([(u) => OrderingTerm.asc(u.id)]);
    return query.watch().map((users) => users
        .map((u) => StoryModel(userName: u.username, avatarUrl: u.avatarUrl!))
        .toList());
  }
}
