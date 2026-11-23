import 'package:android_dev/screens/home_screen/providers/post_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "New post" tab: paste an image URL, see a preview, add a description
/// and publish. The post is written to the database with the current user
/// as the author; the feed stream picks it up automatically.
class NewPostTab extends ConsumerStatefulWidget {
  /// Called after a successful publish (MainScreen switches to the feed).
  final VoidCallback? onPosted;
  const NewPostTab({super.key, this.onPosted});

  @override
  ConsumerState<NewPostTab> createState() => _NewPostTabState();
}

class _NewPostTabState extends ConsumerState<NewPostTab> {
  final _formKey = GlobalKey<FormState>();
  final _url = TextEditingController();
  final _description = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _url.dispose();
    _description.dispose();
    super.dispose();
  }

  String? _validateUrl(String? value) {
    final uri = Uri.tryParse(value?.trim() ?? '');
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https')) ||
        uri.host.isEmpty) {
      return 'Вставьте ссылку, начинающуюся с http:// или https://';
    }
    return null;
  }

  Future<void> _publish() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await ref
        .read(feedControllerProvider)
        .addPost(_url.text.trim(), _description.text.trim());
    if (!mounted) return;
    setState(() => _saving = false);
    _url.clear();
    _description.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Пост опубликован')));
    widget.onPosted?.call();
  }

  @override
  Widget build(BuildContext context) {
    final url = _url.text.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Новый пост')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Preview of the image from the link
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey[300],
                  child: _validateUrl(url) != null
                      ? const Center(
                          child: Icon(Icons.image, size: 64, color: Colors.grey),
                        )
                      : Image.network(
                          url,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Center(
                            child: Text('Не удалось загрузить картинку'),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _url,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Ссылка на картинку',
                hintText: 'https://picsum.photos/600',
                border: OutlineInputBorder(),
              ),
              validator: _validateUrl,
              onChanged: (_) => setState(() {}), // refresh the preview
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _description,
              maxLines: 3,
              maxLength: 500,
              decoration: const InputDecoration(
                labelText: 'Описание',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _saving ? null : _publish,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Опубликовать'),
            ),
          ],
        ),
      ),
    );
  }
}
