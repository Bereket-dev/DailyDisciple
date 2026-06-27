import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../providers/sermon_provider.dart';

class SermonNotesScreen extends ConsumerWidget {
  const SermonNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sermonNotes = ref.watch(sermonNotesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sermon Notes'),
        elevation: 0,
      ),
      body: sermonNotes.when(
        data: (notes) {
          if (notes.isEmpty) {
            return EmptyState(
              icon: '📝',
              title: 'No Sermons Yet',
              subtitle: 'Create your first sermon note to get started',
              actionLabel: 'New Sermon',
              onAction: () => context.push('/home/sermon-notes/create'),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppCard(
                  onTap: () => context.push('/home/sermon-notes/${note.id}'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  note.date,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                ref.read(sermonNotesStateProvider.notifier).deleteSermonNote(note.id);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.preacher,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        note.sermonTopic,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2D3E50),
        onPressed: () => context.push('/home/sermon-notes/create'),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
