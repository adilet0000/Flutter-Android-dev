import 'package:android_dev/screens/content/post_widget.dart';
import 'package:android_dev/screens/home_screen/providers/post_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Activity tab: posts liked by the logged-in account.
class ActivityTab extends ConsumerWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedPostsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Понравившиеся')),
      body: liked.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Ошибка: $error')),
        data: (posts) => posts.isEmpty
            ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 72, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('Вы ещё не лайкнули ни одного поста'),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: PostWidget(post: posts[index]),
                ),
              ),
      ),
    );
  }
}
