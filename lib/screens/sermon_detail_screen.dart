import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../providers/sermon_provider.dart';

class SermonDetailScreen extends ConsumerWidget {
  final int id;

  const SermonDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sermonNote = ref.watch(sermonNoteProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sermon Details'),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                ref.read(sermonNotesStateProvider.notifier).deleteSermonNote(id);
                context.pop();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
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
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.title, style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 8),
                      Text(note.date, style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Preacher', style: Theme.of(context).textTheme.bodySmall),
                              Text(note.preacher, style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Topic', style: Theme.of(context).textTheme.bodySmall),
                              Text(note.sermonTopic, style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(context, 'Scripture', note.scripture),
                const SizedBox(height: 16),
                _buildSection(context, 'Notes', note.notes),
                const SizedBox(height: 16),
                _buildSection(context, 'Key Points', note.keyPoints),
                const SizedBox(height: 16),
                _buildSection(context, 'Quotes', note.quotes),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'View Reflection',
                    onPressed: () => context.push('/home/reflection/$id'),
                  ),
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

  Widget _buildSection(BuildContext context, String title, String content) {
    if (content.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        AppCard(
          child: Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
