import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/app_widgets.dart';
import '../providers/sermon_provider.dart';

class ReflectionScreen extends ConsumerWidget {
  final int sermonNoteId;

  const ReflectionScreen({Key? key, required this.sermonNoteId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sermonNote = ref.watch(sermonNoteProvider(sermonNoteId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflection'),
        elevation: 0,
      ),
      body: sermonNote.when(
        data: (note) {
          if (note == null) {
            return const Center(child: Text('Sermon not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sermon Title', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(note.title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                _buildReflectionCard(
                  context,
                  '🔑',
                  'Key Lessons',
                  note.lessonsLearned ?? 'What are the main lessons from this sermon?',
                ),
                const SizedBox(height: 16),
                _buildReflectionCard(
                  context,
                  '💭',
                  'Summary',
                  note.reflectionSummary ?? 'AI-powered summary would appear here',
                ),
                const SizedBox(height: 16),
                _buildReflectionCard(
                  context,
                  '❓',
                  'Reflection Questions',
                  '''1. How can I apply this teaching?
2. What changes do I need to make?
3. Who can I share this with?''',
                ),
                const SizedBox(height: 16),
                _buildReflectionCard(
                  context,
                  '🙏',
                  'Prayer Suggestions',
                  'Take a moment to pray about what God is teaching you through this sermon.',
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Create Action Steps',
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildReflectionCard(
    BuildContext context,
    String icon,
    String title,
    String content,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
