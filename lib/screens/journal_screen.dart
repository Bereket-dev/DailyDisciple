import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_widgets.dart';
import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../constants/theme.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  String selectedType = 'all';

  @override
  Widget build(BuildContext context) {
    final journalEntries = ref.watch(journalEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              children: [
                _filterChip('all', 'All'),
                _filterChip('reflection', 'Reflection'),
                _filterChip('gratitude', 'Gratitude'),
                _filterChip('prayer', 'Prayer'),
              ],
            ),
          ),
          Expanded(
            child: journalEntries.when(
              data: (entries) {
                final filtered = selectedType == 'all'
                    ? entries
                    : entries.where((e) => e.type == selectedType).toList();

                if (filtered.isEmpty) {
                  return EmptyState(
                    icon: '📖',
                    title: 'No Entries Yet',
                    subtitle: 'Start journaling your spiritual journey',
                    actionLabel: 'Write Entry',
                    onAction: () => _showWriteEntryDialog(context),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final entry = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BadgeWidget(
                                  label: entry.type.toUpperCase(),
                                  backgroundColor: _getTypeColor(entry.type),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'delete') {
                                      ref.read(journalEntriesStateProvider.notifier).deleteJournalEntry(entry.id);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              entry.title,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.createdAt.toString().split(' ')[0],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              entry.content,
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryNavy,
        onPressed: () => _showWriteEntryDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'gratitude':
        return AppTheme.successGreen;
      case 'prayer':
        return AppTheme.primaryNavy;
      case 'reflection':
      default:
        return AppTheme.secondaryGold;
    }
  }

  Widget _filterChip(String type, String label) {
    final isSelected = selectedType == type;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (value) => setState(() => selectedType = type),
      backgroundColor: Colors.transparent,
      selectedColor: AppTheme.primaryNavy,
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSelected ? Colors.white : AppTheme.textMuted,
      ),
    );
  }

  void _showWriteEntryDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();
    String type = 'reflection';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: type,
                items: const [
                  DropdownMenuItem(value: 'reflection', child: Text('Reflection')),
                  DropdownMenuItem(value: 'gratitude', child: Text('Gratitude')),
                  DropdownMenuItem(value: 'prayer', child: Text('Prayer')),
                ],
                onChanged: (value) => type = value ?? 'reflection',
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentCtrl,
                decoration: const InputDecoration(labelText: 'What\'s on your heart?'),
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final now = DateTime.now();
              final entry = JournalEntry(
                id: DateTime.now().millisecondsSinceEpoch,
                title: titleCtrl.text,
                content: contentCtrl.text,
                type: type,
                createdAt: now,
                updatedAt: now,
              );
              ref.read(journalEntriesStateProvider.notifier).addJournalEntry(entry);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
