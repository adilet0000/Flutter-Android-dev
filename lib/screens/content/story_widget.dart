import "package:android_dev/screens/home_screen/models/story_model.dart";
import "package:flutter/material.dart";

/// One story circle: avatar inside a colored ring + user name below.
class StoryWidget extends StatelessWidget {
  final StoryModel story;
  final VoidCallback? onTap;

  const StoryWidget({super.key, required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            // Ring: gradient for new stories, grey for viewed ones
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: story.isViewed
                    ? null
                    : const LinearGradient(
                        colors: [Colors.purple, Colors.red, Colors.orange],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                color: story.isViewed ? Colors.grey[400] : null,
              ),
              // White gap between ring and photo
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: ClipOval(
                    child: Image.network(
                      story.avatarUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              story.userName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
